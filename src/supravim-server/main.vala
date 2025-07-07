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

/**
 * getInputRaw - Get the input from the client (vim) with a pipe
 *
 * @param message: the message received from the client (vim)
 */
public void getInputRaw (string message) {
	uint8 buffer1[128];

	// Send when a file is opened
	// Format: OpenFile: <filename>
	if (message.has_prefix ("OpenFile: ")) {
		unowned string filename = (string)buffer1;
		message.scanf ("OpenFile: %s", buffer1);
		if (filename == "")
			return;

		// Check if an Lsp exist for this file
		var possible_lsp = LspServer.get_lsp_possible (filename);
		var? possible_package = SupportLang.get_package_possible (filename);

		// The Lsp is ever loaded or not exist
		if (LspServer.lsp_is_load (filename) == true) {
			if (possible_package != null) {
				print ("LspInstall: Found a vim-package for color@#@%s\n", possible_package.package_name);
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
		bs.append (filename);
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

	if (message == "todo\n")
	{
		print ("todo:4\n");
		print ("> main.c:3\n");
		print ("> toto.c:1\n");
	}

	// Format:  Install: <lsp_name> <package_name>
	if (message.has_prefix("Install: ")) {
		uint8 buffer2[128];
		message.scanf ("Install: %s %s", buffer1, buffer2);
		unowned string lsp_name = (string)buffer1;
		unowned string package_name = (string)buffer2;
		if (lsp_name != "null")
		{
			foreach (var lsp in LspServer.all_servers) {
				if (lsp.name == lsp_name) {
					string dev_null;
					int wait_status;
					var npm = Environment.find_program_in_path ("npm");
					if (npm == null && lsp.command_help.has_prefix ("npm "))  {
						print ("InstallError: npm is not installed, please install it to use this LSP\n");
					}
					else {
						Process.spawn_command_line_sync (lsp.command_help, out dev_null, out dev_null, out wait_status);
						if (wait_status != 0) {
							print ("InstallError: %s\n", lsp.command_help);
						}
						else {
							unowned string? lsp_str = LspServer.get_from_lsp (lsp);
							print ("LspGetServer@#@%s\n", lsp_str);
						}
					}
				}
			}
		}
		if (package_name != "null") {
			SupportLang.install_package (package_name);
		}
		print ("FinishInstall\n");
	}
}

public string suprapack_list_plugin;

public async int main (string[] args) {
	Process.spawn_command_line_sync ("suprapack list plugin-lang-", out suprapack_list_plugin);
	var monitor = new MyMonitor (args[1]);
	monitor.onStdin.connect (getInputRaw);

	yield monitor.run ();
	return 0;
}
