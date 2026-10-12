public class Command {
	private HashTable<string, bool> lspServerEverLoad = new HashTable<string, bool> (str_hash, str_equal);
	private bool lsp_ready = false;
	private SList<string> LspReady = new SList<string> ();
	public Achievements ach;

	public Command (string project = "") {
		ach = new Achievements (project);
	}

	////////////////////////////////////////////
	// Commands
	////////////////////////////////////////////

	private bool quit_requested = false;

	public void OnQuit () {
		if (quit_requested)
			return;
		quit_requested = true;
		ach.on_quit ();
		Idle.add(SupraVim.main_loop);
	}

	private static string[] tokens (string payload) {
		string[] result = {};
		foreach (unowned string t in payload.strip ().split (" ")) {
			if (t != "")
				result += t;
		}
		return result;
	}

	private static bool is_clean (string s, int max_len) {
		if (s.length == 0 || s.length > max_len)
			return false;
		for (int i = 0; i < s.length; i++) {
			uint8 c = (uint8) s[i];
			if (c < 0x20 || c == 0x7f)
				return false;
		}
		return true;
	}

	// Format: Metric: <name> [<delta>]
	public void OnMetric (string message) {
		var parts = tokens (message.substring ("Metric:".length));
		if (parts.length < 1 || !is_clean (parts[0], 127))
			return;
		int64 delta = parts.length > 1 ? int64.parse (parts[1]) : 0;
		ach.add_metric (parts[0], delta);
	}

	// Format: Ach: <id>
	public void OnAch (string message) {
		var parts = tokens (message.substring ("Ach:".length));
		if (parts.length < 1 || !is_clean (parts[0], 127))
			return;
		ach.force_unlock (parts[0]);
	}

	public void OnBeat () {
		ach.beat ();
	}

	public void OnLspReady () {
		Ready ();
	}

	public void OnOpenFile (string message) {
		// Format: OpenFile: <filetype>|<filename>
		string payload = message.substring ("OpenFile: ".length).strip ();
		int sep = payload.index_of_char ('|');
		if (sep < 1)
			return;
		string filetype = payload[0:sep];
		string filename = payload[sep + 1:];
		if (!is_clean (filetype, 64) || !is_clean (filename, 255))
			return;

		ach.add_lang (filetype);

#if DISCORD_PRESENCE
			SupraVim.discord?.open_file (filetype, filename);
#endif
			if (filetype in lspServerEverLoad)
				return;
			lspServerEverLoad[filetype] = true;
			// Check if an Lsp exist for this file
			var possible_lsp = LspServer.get_lsp_possible (filetype);
			var? possible_package = SupportLang.get_package_possible (filetype);

			// The Lsp is ever loaded or not exist
			if (LspServer.lsp_is_load (filetype) == true) {
				ach.mark_lsp (filetype);
				if (possible_package != null) {
					print ("LspInstall: Suprapack Found a vim-package for color (%s)@#@%s\n", possible_package.package_name, filetype);
				}
				return;
			}

			/***************************
			*        Run The LSP       *
			****************************/

			var bs_error = new StringBuilder ("");
			// Iterate all Lsp possible
			foreach (Lsp lsp in possible_lsp) {
				// Check if the command exists
				// If the command exists, we can use it
				// If the command does not exists, we can not use it and we test another LSP (if exists)
				if (LspServer.if_command_exists (lsp.command)) {
					// If the test command exists, we can use it for test if the LSP is working
					if (lsp.test_command != null) {
						int exit_code = -1;
						try {

							string devnull;
							Process.spawn_command_line_sync (lsp.test_command, out devnull, out devnull, out exit_code);
							if (exit_code != 0)
								throw new SpawnError.FAILED("");
						}
						catch (Error e) {
							bs_error.append_printf ("the LSP exist but the command\r~~\r%s\r~~\rfailed and returns error code [%d]", lsp.command, exit_code);
							continue;
						}
					}
					// If the LSP is working, we can use it
					unowned string? lsp_str = LspServer.get_from_lsp (lsp);
					if (bs_error.len != 0)
						print ("LspServerError:%s\rbut launch %s instead\n", bs_error.str, lsp.name);
					// Send the LSP to the client
					ach.mark_lsp (filetype);
					send_lsp_to_server(lsp_str);
					// print ("LspGetServer@#@%s\n", lsp_str);
					if (possible_package != null) {
						print ("LspInstall: Found a vim-package for color@#@%s\n", possible_package.package_name);
					}
					return;
				}
			}

			// Check if an error need to be displayed
			if (bs_error.len != 0) {
				print ("LspServerError:%s\n", bs_error.str);
				return ;
			}

			if (possible_lsp.length == 0 && possible_package == null) {
				return;
			} 

			/***************************
			*  Installation of the LSP *
			****************************/
			var bs = new StringBuilder ("Support available for ");
			bs.append (filetype);
			bs.append (" click to add it! ");

			foreach (Lsp lsp in possible_lsp) {
				bs.append("@#@");
				bs.append (lsp.name);
			}
			if (possible_package != null) {
				bs.append("@#@");
				bs.append (possible_package.package_name);
			}

			// format: LspInstall: <message>@#@<lsp1>[@#@<lsp2>...]@#@
			print ("LspInstall: %s\n", bs.str);
	}

	// Format:  Install: <lsp_name> <package_name>
	public void OnInstall (string message) {
		var parts = tokens (message.substring ("Install:".length));
		if (parts.length < 2 || !is_clean (parts[0], 127) || !is_clean (parts[1], 127))
			return;
		string lsp_name = parts[0];
		string package_name = parts[1];

		try {
			// Install the LSP if is not null
			if (lsp_name != "null")
				LspServer.install_lsp(lsp_name);
			// Install the package if is not null
			if (package_name != "null")
				SupportLang.install_package (package_name);
			print ("FinishInstall\n");
		}
		catch (Error e) {
			print ("InstallError: %s\n", e.message);
			return;
		}
	}


	/////////////////////////////////////////
	// Private functions
	/////////////////////////////////////////

	private void send_lsp_to_server (string lsp_str) {
		if (!lsp_ready)
			LspReady.append (lsp_str);
		else
			print ("LspGetServer@#@%s\n", lsp_str);
	}

	private void Ready () {
		lsp_ready = true;
		foreach (unowned string lsp in LspReady) {
			print ("LspGetServer@#@%s\n", lsp);
		}
		LspReady = null;
	}
}
