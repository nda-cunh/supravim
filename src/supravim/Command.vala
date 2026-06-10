using Supravim;

namespace Command {

	public bool list (string? group_filter = null, bool only_pinned = false, bool only_disabled = false) throws Error {
		var plugins = Plugin.get_all ();
		if (plugins.is_empty ()) {
			printerr (B + "\033[31mNo plugins found\033[0m\n");
			return false;
		}
		bool any = false;
		foreach (unowned var item in plugins) {
			if (only_pinned   && item.pinned == null)  continue;
			if (only_disabled && item.enabled)          continue;
			if (group_filter  != null) {
				if (item.groups == null || !(group_filter in item.groups.split (",")))
					continue;
			}
			string status = item.enabled ? "\033[32mEnable\033[0m" : "\033[31mDisable\033[0m";
			string extra  = "";
			if (item.pinned != null)
				extra += " [pinned: " + item.pinned + "]";
			if (item.groups != null && item.groups != "")
				extra += " [groups: " + item.groups + "]";
			print ("\033[1m\033[34m%-15s\033[0m " + status + extra + "\n", item.name);
			any = true;
		}
		if (!any)
			printerr ("\033[1m\033[31mNo plugins match the given filters\033[0m\n");
		return any;
	}

	private const string RESET       = "\033[0m";
	private const string GROUP_COLOR = "\033[1;93m";
	private const string NAME_COLOR  = "\033[96m";
	private const string LORE_COLOR  = "\033[98;2m";
	private const string VAL_TRUE    = "\033[92m";
	private const string VAL_FALSE   = "\033[91m";
	private const string VAL_NUMBER  = "\033[94m";
	private const string VAL_STRING  = "\033[97m";
	private const string ENABLED_C   = "\033[92m";
	private const string DISABLED_C  = "\033[91m";

	public void print_status () throws Error {
		var lst = SupraParser.get_from_vim ();
		lst.sort ((a, b) => strcmp(a.id, b.id));
		string[] last_parts = {};
		foreach (var opt in lst) {
			if (opt == null) continue;
			string[] current_parts = opt.id.split("/");
			string path_acc = "";
			for (int i = 0; i < current_parts.length; i++) {
				string segment = current_parts[i];
				bool is_last = (i == current_parts.length - 1);
				path_acc = (path_acc == "") ? segment : path_acc + "/" + segment;
				if (is_last && !(path_acc in SupraParser.group_lores)) break;
				if (i >= last_parts.length || segment != last_parts[i]) {
					string group_lore = "";
					if (SupraParser.group_lores != null && path_acc in SupraParser.group_lores)
						group_lore = SupraParser.group_lores[path_acc].lore;
					print (string.nfill(i * 2, ' ') + GROUP_COLOR + "[" + segment + "]   " + LORE_COLOR + group_lore + RESET + "\n");
				}
				if (is_last) break;
			}
			string short_name = current_parts[current_parts.length - 1];
			int depth = current_parts.length - 1;
			if (opt.id in SupraParser.group_lores) depth++;
			string opt_indent = string.nfill(depth * 2 + 2, ' ');
			string v_color = VAL_STRING;
			if (opt.value == "true") v_color = VAL_TRUE;
			else if (opt.value == "false") v_color = VAL_FALSE;
			else if (opt.type == "number") v_color = VAL_NUMBER;
			print (opt_indent + NAME_COLOR + short_name + RESET + ": " +
				v_color + opt.value + RESET + "\033[31j" + LORE_COLOR + opt.lore + RESET + "\n");
			last_parts = current_parts;
		}
	}

	public void print_options () throws Error {
		var lst = SupraParser.get_from_vim ();
		foreach (unowned var opt in lst) {
			if (opt == null) continue;
			print ("%s:%s\n", opt.id, opt.lore);
		}
	}

	public void print_options_switchable () throws Error {
		var lst = SupraParser.get_from_vim ();
		foreach (unowned var opt in lst) {
			if (opt == null || opt.type != "bool") continue;
			unowned string color = (opt.value == "true") ? ENABLED_C : DISABLED_C;
			print ("%s:%s%s\033[0m\n", opt.id, color, opt.lore);
		}
	}
}
