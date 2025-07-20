namespace Plugin {
	/**
	 * Add a plugin to the list of plugins.
	 * @param url The URL of the plugin to add.
	 * @return true if the plugin was added successfully, false otherwise.
	 */
	public bool add (string url) throws Error {
		var plugins = new PluginsLst ();
		int wait;
		int	idx = url.last_index_of_char ('/');
		string name = url[idx + 1:];

		name._delimit (".", '\0');
		if (plugins.add_from_url (url, name) == false) {
			printerr (BOLD + RED + "Plugin %s already exists\n" + DEFAULT, name);
			return false;
		}
		Process.spawn_command_line_sync(@"git clone --depth=1 $url $HOME/.vim/bundle/$name", null, null, out wait);
		if (wait != 0) {
			plugins.remove_from_name (name);
			throw new SpawnError.FAILED("git return %d", wait);
		}
		return true;
	}

	/**
	 * Remove a plugin from the list of plugins.
	 * @param name The name of the plugin to remove.
	 * @return true if the plugin was removed successfully, false otherwise.
	 */
	public bool remove (string name) throws Error {
		var plugins = new PluginsLst ();

		if (!plugins.remove_from_name (name)) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		Process.spawn_command_line_sync (@"rm -rf $HOME/.vim/bundle/$name");
		print (BOLD + GREEN + "Plugin %s removed successfully\n" + DEFAULT, name);
		return true;
	}

	/**
	 * Disable a plugin.
	 * @param name The name of the plugin to disable.
	 * @return true if the plugin was disabled successfully, false otherwise.
	 */
	public bool disable(string name) throws Error {
		var plugins = new PluginsLst ();
		int index;
		unowned string? item = plugins.get_from_name (name, out index);

		if (item == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}

		if (plugins.is_enable (index) == false) {
			printerr (BOLD + RED + "Plugin %s already disabled\n" + DEFAULT, name);
			return false;
		}
		plugins.disable (index);
		print (BOLD + GREEN + "Plugin %s disabled successfully\n" + DEFAULT, name);
		return true;
	}

	/**
	 * Enable a plugin.
	 * @param name The name of the plugin to enable.
	 * @return true if the plugin was enabled successfully, false otherwise.
	 */
	public bool enable(string name) throws Error {
		var plugins = new PluginsLst ();
		int index;
		unowned string? item = plugins.get_from_name (name, out index);

		if (item == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}

		if (plugins.is_enable (index) == true) {
			printerr (BOLD + RED + "Plugin %s already enabled\n" + DEFAULT, name);
			return false;
		}
		plugins.enable (index);
		print (BOLD + GREEN + "Plugin %s enabled successfully\n" + DEFAULT, name);
		return true;
	}

	/**
	 * Update all plugins.
	 * @return true if all plugins were updated successfully, false otherwise.
	 */
	public bool update_all () throws Error {
		var plugins = new PluginsLst ();
		foreach (unowned string item in plugins) {
			int index;
			unowned string name = item.offset (item.last_index_of_char (' ') + 1);
			Process.spawn_command_line_sync (@"git -C $HOME/.vim/bundle/$name pull");
		}
		return true;
	}

	/**
	 * Update a specific plugin.
	 * @param name The name of the plugin to update.
	 * @return true if the plugin was updated successfully, false otherwise.
	 */
	public bool update (string name) throws Error {
		var plugins = new PluginsLst ();
		int index;
		unowned string? item = plugins.get_from_name (name, out index);
		if (item == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		Process.spawn_command_line_sync (@"git -C $HOME/.vim/bundle/$name pull");
		return true;
	}

	/**
	 * List all plugins.
	 * @return true if the list was displayed successfully, false if no plugins were found.
	 */
	public bool list () throws Error {
		unowned string name;
		var plugins = new PluginsLst ();

		if (plugins.size == 0) {
			printerr (BOLD + RED + "No plugins found\n" + DEFAULT);
			return false;
		}

		foreach (unowned var item in plugins) {
			name = item.offset (item.last_index_of_char (' ') + 1);
			if (item[0] == 'E')
				print (BOLD + "%-15s " + GREEN + "%s" + DEFAULT + "\n", name, "Enable");
			else
				print (BOLD + "%-15s " + RED + "%s" + DEFAULT + "\n", name, "Disable");
		}
		return true;
	}
}
