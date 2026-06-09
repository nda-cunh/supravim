namespace Plugin {

	internal class PluginEntry {
		public string  name;
		public string  url;
		public bool    enabled          = true; // if false, the plugin is ignored by vim 
		public string? pinned           = null; // Hash commit pinned
		public string? installed_commit = null; // Hash of the commit when installed or last updated
		public string? added_at         = null; // "YYYY-MM-DD"
		public string? groups           = null; // groups separated by ','

		public PluginEntry (string name, string url, bool enabled = true) {
			this.name    = name;
			this.url     = url;
			this.enabled = enabled;
		}
	}

	internal class PluginsLst {

		private string filename     = Environment.get_user_config_dir () + "/supravim.json";
		private string old_filename = Environment.get_user_config_dir () + "/supravim.cfg";
		private GenericArray<PluginEntry> array = new GenericArray<PluginEntry> ();

		public PluginsLst () throws Error {
			if (FileUtils.test (old_filename, FileTest.EXISTS))
				migrate_from_cfg ();
			else if (FileUtils.test (filename, FileTest.EXISTS))
				load_from_json ();
		}

		~PluginsLst () {
			try { save_to_json (); }
			catch (Error e) { warning ("Error saving plugins list: %s\n", e.message); }
		}

		////////////////
		// Member Functions
		////////////////

		public PluginEntry? get_from_name (string name) {
			for (int i = 0; i < (int) array.length; i++)
				if (array.data[i].name == name)
					return array.data[i];
			return null;
		}

		public bool add_from_url (string url, string name) {
			if (get_from_name (name) != null)
				return false;
			var entry = new PluginEntry (name, url);
			entry.added_at = new DateTime.now_local ().format ("%Y-%m-%d");
			array.add (entry);
			return true;
		}

		public bool remove_from_name (string name) {
			for (int i = 0; i < (int) array.length; i++) {
				if (array.data[i].name == name) {
					array.remove_index (i);
					return true;
				}
			}
			return false;
		}

		////////////////
		// Properties
		////////////////

		public unowned PluginEntry get (int index) { return array.data[index]; }
		public uint size { get { return array.length; } }

		////////////////
		// Private: JSON I/O + migration
		////////////////

		private void load_from_json () throws Error {
			string contents;
			FileUtils.get_contents (filename, out contents);
			var doc = YYJson.Doc.read (contents, contents.length);
			if (doc == null) return;

			unowned var root = doc.get_root ();
			unowned var arr  = root.obj_get ("plugins");
			if (arr == null) return;

			size_t n = arr.arr_size ();
			for (size_t i = 0; i < n; i++) {
				unowned var e = arr.arr_get (i);
				unowned var name_v    = e.obj_get ("name");
				unowned var url_v     = e.obj_get ("url");
				unowned var enabled_v = e.obj_get ("enabled");
				if (name_v == null || url_v == null) continue;

				var entry = new PluginEntry (
					name_v.get_str (),
					url_v.get_str (),
					enabled_v == null || enabled_v.get_bool ()
				);

				unowned var pinned_v  = e.obj_get ("pinned");
				unowned var commit_v  = e.obj_get ("installed_commit");
				unowned var added_v   = e.obj_get ("added_at");
				unowned var groups_v  = e.obj_get ("groups");

				if (pinned_v != null) entry.pinned           = pinned_v.get_str ();
				if (commit_v != null) entry.installed_commit = commit_v.get_str ();
				if (added_v  != null) entry.added_at         = added_v.get_str ();
				if (groups_v != null) {
					string[] glist = {};
					for (size_t j = 0; j < groups_v.arr_size (); j++)
						glist += groups_v.arr_get (j).get_str ();
					if (glist.length > 0)
						entry.groups = string.joinv (",", glist);
				}

				array.add (entry);
			}
		}

		private void save_to_json () throws Error {
			var doc = new YYJson.MutDoc ();
			unowned var root = doc.obj ();
			doc.set_root (root);
			unowned var arr = root.obj_add_arr (doc, "plugins");

			for (int i = 0; i < (int) array.length; i++) {
				unowned var item  = array.data[i];
				unowned var entry = arr.arr_add_obj (doc);
				if (entry == null) continue;

				entry.obj_add_str  (doc, "name",    item.name);
				entry.obj_add_str  (doc, "url",     item.url);
				entry.obj_add_bool (doc, "enabled", item.enabled);

				if (item.pinned           != null) entry.obj_add_str (doc, "pinned",           item.pinned);
				if (item.installed_commit != null) entry.obj_add_str (doc, "installed_commit",  item.installed_commit);
				if (item.added_at         != null) entry.obj_add_str (doc, "added_at",          item.added_at);
				if (item.groups != null && item.groups != "") {
					unowned var ga = entry.obj_add_arr (doc, "groups");
					if (ga != null)
						foreach (string g in item.groups.split (","))
							ga.arr_add_str (doc, g);
				}
			}

			string? json_str = doc.write (YYJson.WRITE_PRETTY);
			if (json_str != null)
				FileUtils.set_contents (filename, json_str);
		}

		// Read the old format "E/D <url> <name>", save in JSON, delete the .cfg
		private void migrate_from_cfg () throws Error {
			string contents;
			FileUtils.get_contents (old_filename, out contents);
			foreach (string line in contents.split ("\n")) {
				if (line.length < 4) continue;
				bool enabled    = line[0] == 'E';
				int  last_space = line.last_index_of_char (' ');
				if (last_space < 2) continue;
				array.add (new PluginEntry (line.offset (last_space + 1), line[2:last_space], enabled));
			}
			save_to_json ();
			FileUtils.remove (old_filename);
		}
	}
}
