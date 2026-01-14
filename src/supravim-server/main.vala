/**
 * Supravim - Server
 *
 * this is the server part of the supravim project
 * it will be used to manage the files and the users
 * refresh the tree view and the file view
 *
 * And return the good Lsp for the language
 *
 **/


private string suprapack_list_plugin;
private bool suprapack_list_plugin_loaded = false;

private async void load_suprapack_list_plugin () {
	var thread = new Thread<string>(null, () => {
		string content;
		Process.spawn_command_line_sync ("suprapack list plugin-lang-", out content);
		Idle.add(load_suprapack_list_plugin.callback);
		return content;
	});
	yield;
	suprapack_list_plugin = thread.join ();
	suprapack_list_plugin_loaded = true;
}

// Get the suprapack list of plugin-lang-*
public static string? get_suprapack_list_plugin () {
	if (suprapack_list_plugin_loaded == false)
		return null;
	return suprapack_list_plugin;
}


public class SupraVim {
	SourceFunc? main_loop = null;
	MyMonitor monitor;
	StdinStream stdin;
	DiscordSupraVim discord;

	private SupraVim (string [] args) throws Error {
		load_suprapack_list_plugin.begin ();
		suprapack_list_plugin_loaded = false;
		monitor = new MyMonitor (args[1]);
		stdin = new StdinStream ();

		// Discord Rich Presence
		try {
			discord = new DiscordSupraVim ("1399862365800894584");
			discord.state = "Opening Supravim";
			discord.details = "Editing code";
			discord.large_image = "vala";
			discord.run.begin ( () => discord.send_actvity.begin());
		}
		catch (Error e) {
			printerr ("Discord Error: %s\n", e.message);
		}
	}

	private async void run () {
		main_loop = run.callback;
		stdin.onStdin.connect (getInputRaw);

		yield;
	}

	public static async int main (string[] args) {
		try {
			var supravim = new SupraVim (args);
			yield supravim.run ();
		}
		catch (Error e) {
			printerr ("Error: %s\n", e.message);
			return 1;
		}
		return 0;
	}


	/**
	* getInputRaw - Get the input from the client (vim) with a pipe
	*
	* @param message: the message received from the client (vim)
	*/
	private void getInputRaw (string message) {
		uint8 buffer1[128];
		uint8 buffer2[128];

		// Send when a file is opened
		// Format: OpenFile: <filename>
		if (message.has_prefix ("QUIT")) {
			Idle.add(main_loop);
		}
		if (message.has_prefix ("OpenFile: ")) {
			unowned string filetype = (string)buffer1;
			unowned string filename = (string)buffer2;
			message.scanf ("OpenFile: %[^|]|%s", buffer1, buffer2);
			if (filetype == "")
				return;

			discord?.open_file (filetype, filename);
			// Check if an Lsp exist for this file
			var possible_lsp = LspServer.get_lsp_possible (filetype);
			var? possible_package = SupportLang.get_package_possible (filetype);

			// The Lsp is ever loaded or not exist
			if (LspServer.lsp_is_load (filetype) == true) {
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
					print ("LspGetServer@#@%s\n", lsp_str);
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
		if (message.has_prefix("Install: ")) {
			message.scanf ("Install: %s %s", buffer1, buffer2);
			unowned string lsp_name = (string)buffer1;
			unowned string package_name = (string)buffer2;

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
	}
}

