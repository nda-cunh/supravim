namespace Plugin {

	internal class PluginsLst {

		private string filename     = Environment.get_user_config_dir () + "/supravim.json";
		private string old_filename = Environment.get_user_config_dir () + "/supravim.cfg";
		private GenericArray<string> array = new GenericArray<string> ();

		public PluginsLst () throws Error {
			if (FileUtils.test (old_filename, FileTest.EXISTS))
				migrate_from_cfg ();
			else if (FileUtils.test (filename, FileTest.EXISTS))
				load_from_json ();
		}

		~PluginsLst () {
			try {
				save_to_json ();
			} catch (Error e) {
				warning ("Error saving plugins list: %s\n", e.message);
			}
		}

		////////////////
		// Member Functions
		////////////////

		public unowned string? get_from_name (string name, out uint index) {
			index = 0;
			foreach (unowned string item in array) {
				var idx = item.last_index_of_char (' ') + 1;
				if (name == item.offset (idx)) {
					return item;
				}
				index += 1;
			}
			return null;
		}

		public bool add_from_url (string url, string name) {
			uint index;
			unowned string? str = get_from_name (name, out index);
			if (str != null)
				return false;
			array.add (@"E $url $name");
			return true;
		}

		public bool remove_from_name (string name) {
			uint index;
			unowned string? item = get_from_name (name, out index);
			if (item != null) {
				array.remove_index (index);
				return true;
			}
			return false;
		}

		public bool is_enable (uint index) {
			unowned string item = array.data[index];
			return item[0] == 'E';
		}

		public void enable (uint index) {
			unowned string item = array.data[index];
			item.data[0] = 'E';
		}

		public void disable (uint index) {
			unowned string item = array.data[index];
			item.data[0] = 'D';
		}

		////////////////
		// Properties
		////////////////

		public unowned string get (int index) { return array.data[index]; }
		public uint size { get { return array.length; } }

		////////////////
		// Private: JSON I/O + migration
		////////////////

		private void load_from_json () throws Error {
			string contents;
			FileUtils.get_contents (filename, out contents);
			var doc = YYJson.Doc.read (contents, contents.length);
			if (doc == null)
				return;

			unowned var root = doc.get_root ();
			unowned var plugins_arr = root.obj_get ("plugins");
			if (plugins_arr == null)
				return;

			size_t n = plugins_arr.arr_size ();
			for (size_t i = 0; i < n; i++) {
				unowned var entry = plugins_arr.arr_get (i);
				unowned var name_v    = entry.obj_get ("name");
				unowned var url_v     = entry.obj_get ("url");
				unowned var enabled_v = entry.obj_get ("enabled");
				if (name_v == null || url_v == null)
					continue;
				bool enabled = enabled_v == null || enabled_v.get_bool ();
				array.add (@"$(enabled ? "E" : "D") $(url_v.get_str ()) $(name_v.get_str ())");
			}
		}

		private void save_to_json () throws Error {
			var doc = new YYJson.MutDoc ();
			unowned var root = doc.obj ();
			doc.set_root (root);
			unowned var arr = root.obj_add_arr (doc, "plugins");

			foreach (unowned string item in array) {
				if (item.length == 0)
					continue;
				bool enabled = item[0] == 'E';
				int last_space = item.last_index_of_char (' ');
				if (last_space < 2)
					continue;
				string url  = item[2:last_space];
				string name = item.offset (last_space + 1);

				unowned var entry = arr.arr_add_obj (doc);
				if (entry == null)
					continue;
				entry.obj_add_str  (doc, "name",    name);
				entry.obj_add_str  (doc, "url",     url);
				entry.obj_add_bool (doc, "enabled", enabled);
			}

			string? json_str = doc.write (YYJson.WRITE_PRETTY);
			if (json_str != null)
				FileUtils.set_contents (filename, json_str);
		}

		// Lit l'ancien format "E/D <url> <name>", sauvegarde en JSON, supprime le .cfg
		private void migrate_from_cfg () throws Error {
			string contents;
			FileUtils.get_contents (old_filename, out contents);
			var lines = contents.split ("\n");
			array.data = (owned) lines;
			save_to_json ();
			FileUtils.remove (old_filename);
		}
	}
}
