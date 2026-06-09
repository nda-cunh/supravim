public struct SupravimOption {
	public string id;
	public string lore;
	public string value;
	public string type;
	public string default_value;

	public static SupravimOption empty () {
		return SupravimOption () {
			id = "", lore = "", value = "", type = "", default_value = ""
		};
	}
}

public struct SupravimGroup {
	public string id;
	public string lore;
}

public class SupraParser {
	public static HashTable<string, SupravimGroup?> group_lores;

	public static List<SupravimOption?> get_from_vim () throws Error {
		string output;
		string errput;
		string name_used;
		FileUtils.open_tmp ("tmp_vim_redir_XXXXXXXX", out name_used);
		Process.spawn_command_line_sync (
			@"vim -es -u ~/.vimrc -c 'redir! > $name_used | call supraconfig#PrintRegister() | redir END' -c 'q'",
			out output, out errput
		);
		FileUtils.get_contents (name_used, out output);
		FileUtils.remove (name_used);
		return parse_full_package (output);
	}

	public static List<SupravimOption?> parse_full_package (string json) {
		group_lores = new HashTable<string, SupravimGroup?> (str_hash, str_equal);
		var options_list = new List<SupravimOption?> ();

		var doc = YYJson.Doc.read (json, json.length);
		if (doc == null) return options_list;

		unowned var root = doc.get_root ();

		// Parse groups: {"group_id": "group_lore", ...}
		unowned var groups_val = root.obj_get ("groups");
		if (groups_val != null) {
			YYJson.ObjIter iter;
			if (YYJson.ObjIter.init (groups_val, out iter)) {
				unowned YYJson.Value? key;
				while ((key = iter.next ()) != null) {
					string? k = key.get_str ();
					unowned var v_node = YYJson.ObjIter.get_val (key);
					if (k == null || v_node == null) continue;
					string lore = v_node.get_str () ?? "";
					group_lores.insert (k, SupravimGroup () { id = k, lore = lore });
				}
			}
		}

		// Parse options: {"opt_id": {"id":…, "lore":…, "current":…, "type":…, "default":…}, …}
		unowned var options_val = root.obj_get ("options");
		if (options_val != null) {
			YYJson.ObjIter iter;
			if (YYJson.ObjIter.init (options_val, out iter)) {
				unowned YYJson.Value? key;
				while ((key = iter.next ()) != null) {
					unowned var entry = YYJson.ObjIter.get_val (key);
					if (entry == null) continue;

					SupravimOption opt = SupravimOption ();
					unowned var id_v      = entry.obj_get ("id");
					unowned var lore_v    = entry.obj_get ("lore");
					unowned var current_v = entry.obj_get ("current");
					unowned var type_v    = entry.obj_get ("type");
					unowned var default_v = entry.obj_get ("default");

					opt.id            = (id_v      != null ? id_v.get_str ()      : null) ?? "";
					opt.lore          = (lore_v    != null ? lore_v.get_str ()    : null) ?? "";
					opt.value         = (current_v != null ? current_v.get_str () : null) ?? "";
					opt.type          = (type_v    != null ? type_v.get_str ()    : null) ?? "";
					opt.default_value = (default_v != null ? default_v.get_str () : null) ?? "";

					options_list.append (opt);
				}
			}
		}

		return options_list;
	}
}
