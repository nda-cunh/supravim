namespace Plugin {

	internal class PluginsLst {

		private string filename = Environment.get_user_config_dir () + "/supravim.cfg";
		private Array<string> array = new Array<string> ();

		/***
		 * Constructor for PluginsLst.
		 * Reads the plugins list from the configuration file.
		 * Throws an Error if the file cannot be read.
		 */
		public PluginsLst () throws Error {
			string contents;
			FileUtils.get_contents (filename, out contents);
			var data = contents.split ("\n");
			var len = data.length;
			array.append_vals ((owned)data, len);
		}

		/**
		 * Destructor for PluginsLst.
		 * Saves the plugins list to the configuration file.
		 */
		~PluginsLst () {
			try {
				var bs = new StringBuilder ();
				foreach (unowned string item in array) {
					bs.append (item);
					bs.append_c ('\n');
				}
				FileUtils.set_contents (filename, bs.str._strip());
			}
			catch (Error e) {
				warning ("Error saving plugins list: %s\n", e.message);
			}
		}

		////////////////
		// Member Functions 
		////////////////

		/**
		 * Get a plugin by its name.
		 * @param name The name of the plugin to search for.
		 * @param index Output parameter to store the index of the found plugin.
		 * @return The plugin string if found, null otherwise.
		 */
		public unowned string? get_from_name (string name, out int index) {
			index = 0;
			foreach (unowned string item in array) {
				var idx = item.last_index_of_char (' ') + 1;
				if (name == item.offset (idx)) {
					return item;
				}
				index++;
			}
			return null;
		}

		/**
		 * Add a plugin from a URL.
		 * @param url The URL of the plugin.
		 * @param name The name of the plugin.
		 * @return true if the plugin was added successfully, false if it already exists.
		 */
		public bool add_from_url (string url, string name) {
			int index;
			unowned string? str = get_from_name (name, out index);
			if (str != null)
				return false;
			array.append_val (@"E $url $name");
			return true;
		}

		/**
		 * Add a plugin from a name.
		 * @param name The name of the plugin.
		 * @return true if the plugin was added successfully, false if it already exists.
		 */
		public bool remove_from_name (string name) {
			int index;
			var item = get_from_name (name, out index);
			if (item != null) {
				array.remove_index(index);
				return true;
			}
			return false;
		}

		/**
		 * Get the plugin at a specific index.
		 * @param index The index of the plugin to retrieve.
		 * @return The plugin string at the specified index.
		 */
		public bool is_enable (int index) {
			unowned string item = array.data[index];
			return item[0] == 'E';
		}

		/**
		 * Enable a plugin at a specific index.
		 * @param index The index of the plugin to enable.
		 */
		public void enable (int index) {
			unowned string item = array.data[index];
			item.data[0] = 'E';
		}

		/**
		 * Disable a plugin at a specific index.
		 * @param index The index of the plugin to disable.
		 */
		public void disable (int index) {
			unowned string item = array.data[index];
			item.data[0] = 'D';
		}


		////////////////
		// Properties 
		////////////////

		// Getter for the plugin at a specific index.
		public unowned string get (int index) { return array.data[index]; }
		// Getter for the size of the plugin list.
		public uint size { get { return array.length; } }
	}
}
