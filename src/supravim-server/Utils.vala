namespace Utils {
	private string suprapack_list_plugin;
	private bool suprapack_list_plugin_loaded = false;

	private async void load_suprapack_list_plugin () {
		var thread = new Thread<string>(null, () => {
			string content;
			try {
				Process.spawn_command_line_sync ("suprapack list plugin-lang-", out content);
			}
			catch (Error e) {
				printerr ("Error loading suprapack list plugin: %s\n", e.message);
				content = "";
			}
			Idle.add(load_suprapack_list_plugin.callback);
			return content;
		});
		yield;
		suprapack_list_plugin = thread.join ();
		suprapack_list_plugin_loaded = true;
	}

	public void init_suprapack_list_plugin () {
		load_suprapack_list_plugin.begin ();
		suprapack_list_plugin_loaded = false;
	}

	// Get the suprapack list of plugin-lang-*
	public static string? get_suprapack_list_plugin () {
		if (suprapack_list_plugin_loaded == false)
			return null;
		return suprapack_list_plugin;
	}
}
