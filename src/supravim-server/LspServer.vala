public struct Lsp {
	string name;
	string command;
	string allowed;
	string? test_command;
	string? command_help;
	int priority;
}

/**
 * LspServer - LSP server management
 *
 * Servers are loaded from JSON files in:
 * {XDG_CONFIG_HOME}/supravim/lsp.d/ (user config, e.g. ~/.config/supravim/lsp.d/)
 * {XDG_DATA_HOME}/supravim/lsp.d/   (user data, e.g. ~/.local/share/supravim/lsp.d/)
 * {XDG_DATA_DIRS}/supravim/lsp.d/   (system, e.g. /usr/share/supravim/lsp.d/)
 *
 * The user configuration directory is loaded first, followed by user data,
 * then system directories. If two files have the same "name" field, the first
 * one loaded wins.
 * The optional "priority" field (int) controls the preference order for
 * languages with multiple servers available (e.g., clangd > ccls).
 */
namespace LspServer {

	public unowned Lsp[] get_all_servers () {
		if (_all_servers == null)
			_all_servers = load_servers ();
		return _all_servers;
	}

	private string get_command (string command) {
		string cmd;
		int idx = command.index_of_char (',');

		if (idx != -1)
			cmd = command[0: idx];
		else
			cmd = command;
		return cmd;
	}

	private bool if_command_exists (string command) {
		var cmd = get_command (command);
		if (Environment.find_program_in_path (cmd) != null)
			return true;
		return false;
	}

	private bool lsp_is_load (string name) {
		if (get_is_loaded ()[name] != null)
			return true;
		return false;
	}

	private Lsp[] get_lsp_possible (string name) {
		Lsp[] servers = {};
		foreach (Lsp server in get_all_servers ()) {
			if (name in server.allowed.split (",")) {
				servers += server;
			}
		}
		return servers;
	}

	public unowned string get_from_lsp (Lsp server) {
		unowned var bs = get_bs ();
		bs.len = 0;
		bs.printf ("%s@#@%s@#@%s", server.name, server.command, server.allowed);
		foreach (var n in server.allowed.split (","))
			get_is_loaded ()[n] = server;
		bs.replace ("$USER", Environment.get_user_name ());
		return bs.str;
	}

	public int run_command (string command) {
		int wait_status;
		string dev_null;
		Process.spawn_command_line_sync (command, out dev_null, out dev_null, out wait_status);
		return wait_status;
	}

	public void npm_install (Lsp lsp) throws Error {
		var npm = Environment.find_program_in_path ("npm");
		if (npm == null) {
			throw new ErrorLsp.INSTALL_ERROR ("Npm is not installed");
		}

		int wait_status = run_command (lsp.command_help);
		if (wait_status != 0) {
			if (Environment.get_variable ("FT_HOOK_NAME") != null) {
				run_command ("suprapack add nodejs --yes");
				wait_status = run_command (lsp.command_help);
				if (wait_status != 0) {
					throw new ErrorLsp.INSTALL_ERROR ("Error can't install with npm\r~~\r(%s)\r~~\rinstall nodejs with suprapack ?", lsp.command_help);
				}
			}
			else
				throw new ErrorLsp.INSTALL_ERROR ("Error can't install with npm\r~~\r(%s)\r~~\rinstall nodejs with suprapack ?", lsp.command_help);
		}
		unowned string? lsp_str = LspServer.get_from_lsp (lsp);
		print ("LspGetServer@#@%s\n", lsp_str);
	}

	public void suprapack_install (Lsp lsp) throws Error {
		int wait_status = run_command (lsp.command_help);
		if (wait_status != 0) {
			throw new ErrorLsp.INSTALL_ERROR ("Error running suprapack command\r(%s)", lsp.command_help);
		}
		else {
			unowned string? lsp_str = LspServer.get_from_lsp (lsp);
			print ("LspGetServer@#@%s\n", lsp_str);
		}
	}

	public void other_install (Lsp lsp) throws Error {
		int wait_status = run_command (lsp.command_help);
		if (wait_status != 0) {
			throw new ErrorLsp.INSTALL_ERROR ("Error running install command\r(%s)", lsp.command_help);
		}
		else {
			unowned string? lsp_str = LspServer.get_from_lsp (lsp);
			print ("LspGetServer@#@%s\n", lsp_str);
		}
	}

	public void install_lsp (string name) throws Error {
		foreach (Lsp lsp in get_all_servers ()) {
			if (lsp.name == name) {
				if (lsp.command_help.has_prefix ("npm ")) {
					npm_install (lsp);
				}
				else if (lsp.command_help.has_prefix ("suprapack ")) {
					suprapack_install (lsp);
				}
				else {
					other_install (lsp);
				}
				return;
			}
		}
		throw new ErrorLsp.NOT_FOUND ("LSP '%s' not found", name);
	}

	// -------------------------------------------------------------------------
	// load from lsp.d/
	// -------------------------------------------------------------------------

	private Lsp[] load_servers () {
		Lsp[] servers = {};
		var seen = new HashTable<string, bool> (str_hash, str_equal);

		// From ~/.config/supravim/lsp.d/

		// From ~/.local/share/supravim/lsp.d/
		foreach (Lsp s in load_from_dir (
				Path.build_filename (Environment.get_user_data_dir (), "supravim", "lsp.d"), seen))
			servers += s;

		// From /usr/share/supravim/lsp.d/
		foreach (unowned string sys in Environment.get_system_data_dirs ()) {
			foreach (Lsp s in load_from_dir (Path.build_filename (sys, "supravim", "lsp.d"), seen))
				servers += s;
		}

		sort_by_priority (ref servers);
		return servers;
	}

	private Lsp[] load_from_dir (string dir_path, HashTable<string, bool> seen) {
		Lsp[] servers = {};
		try {
			var dir = Dir.open (dir_path);
			string? entry;
			while ((entry = dir.read_name ()) != null) {
				if (!entry.has_suffix (".json"))
					continue;
				try {
					Lsp lsp = parse_lsp_file (Path.build_filename (dir_path, entry));
					if (!seen.contains (lsp.name)) {
						seen[lsp.name] = true;
						servers += lsp;
					}
				} catch (Error e) { }
			}
		} catch (FileError e) { }
		return servers;
	}

	private Lsp parse_lsp_file (string path) throws Error {
		string data;
		FileUtils.get_contents (path, out data);

		var doc = YYJson.Doc.read (data, data.length);
		if (doc == null)
			throw new ErrorLsp.INVALID_LSP ("Cannot parse JSON: %s", path);

		unowned var root = doc.get_root ();
		unowned var name_v    = root.obj_get ("name");
		unowned var command_v = root.obj_get ("command");
		unowned var allowed_v = root.obj_get ("allowed");

		if (name_v == null || command_v == null || allowed_v == null)
			throw new ErrorLsp.INVALID_LSP ("Missing required field in %s", path);

		Lsp lsp = {};
		lsp.name    = name_v.get_str ();
		lsp.command = command_v.get_str ();
		lsp.allowed = allowed_v.get_str ();

		unowned var test_v = root.obj_get ("test_command");
		if (test_v != null)
			lsp.test_command = test_v.get_str ();

		unowned var help_v = root.obj_get ("command_help");
		if (help_v != null)
			lsp.command_help = help_v.get_str ();

		unowned var prio_v = root.obj_get ("priority");
		if (prio_v != null)
			lsp.priority = prio_v.get_int ();

		return lsp;
	}

	private void sort_by_priority (ref Lsp[] arr) {
		for (int i = 1; i < arr.length; i++) {
			Lsp key = arr[i];
			int j = i - 1;
			while (j >= 0 && arr[j].priority < key.priority) {
				arr[j + 1] = arr[j];
				j--;
			}
			arr[j + 1] = key;
		}
	}

	// -------------------------------------------------------------------------
	// internal 
	// -------------------------------------------------------------------------

	private Lsp[]? _all_servers = null;

	public HashTable<string, Lsp?> get_is_loaded () {
		if (_is_loaded == null) {
			_is_loaded = new HashTable<string, Lsp?> (str_hash, str_equal);
		}
		return _is_loaded;
	}
	private HashTable<string, Lsp?>? _is_loaded = null;
	private StringBuilder? _bs = null;
	private unowned StringBuilder get_bs () {
		if (_bs == null) {
			_bs = new StringBuilder ();
		}
		return _bs;
	}
}

public errordomain ErrorLsp {
	NOT_FOUND,
	INSTALL_ERROR,
	COMMAND_ERROR,
	INVALID_LSP,
	UNKNOWN_ERROR
}
