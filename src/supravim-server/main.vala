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

public struct Lsp {
	string name; // the name of the language
	string command;// command separated by ','
	string allowed; // filetype like vala, c, cpp, py, js, ts, lua
	string? test_command; // command to test if the lsp is working
	string? help; // help message
	string? command_help; // help message
}

public class LspServer {

	public static string get_command (string command) {
		string cmd;
		int idx = command.index_of_char (',');

		if (idx != -1)
			cmd = command[0: idx];
		else
			cmd = command;
		return cmd;
	}

	public static bool if_command_exists (string command) {
		var cmd = get_command (command);
		if (Environment.find_program_in_path (cmd) != null)
			return true;
		return false;
	}

	public static bool lsp_is_load(string name) {
		if (is_loaded[name] != null)
			return true;
		return false;
	}

	public static Lsp[] get_lsp_possible (string name) {
		Lsp []servers = {};
		foreach (Lsp server in all_servers) {
			if (name in server.allowed.split (",")) {
				servers += server;
			}
		}
		return servers;
	}

	public static unowned string get_from_lsp (Lsp server) {
		bs.len = 0;
		bs.printf("%s@#@%s@#@%s", server.name, server.command, server.allowed);
		foreach (var n in server.allowed.split(","))
			is_loaded[n] = server;
		return bs.str;
	}


	public const Lsp[] all_servers = {
		{ "asm", "asm-lsp", "s,asm,nasm",
			null,
			null,
			"suprapack add asm-lsp --yes"},
		{ "blueprint", "blueprint-compiler,lsp", "blp,bp,blueprint",
			"blueprint-compiler --version",
			null,
			"suprapack add blueprint-compiler --yes"},
		{ "pylsp", "pyls", "py,python",
			"pylsp -h",
			null,
			"pip install python-lsp-server[all]"},
		{"kotlin-lsp", "kotlin-language-server", "kt,kts,kotlin",
			null,
			null,
			"suprapack add kotlin-language-server --yes"},
		{ "vls", "vala-language-server", "vala,vapi",
			"vala-language-server --help",
			null,
			"suprapack add vala-language-server --yes"},
		{ "bash-lsp", "bash-language-server,start", "sh,bash",
			"bash-language-server --version",
			null,
			"xdg-open https://github.com/bash-lsp/bash-language-server"},
		{ "dart-lsp", "dart,language-server", "dart",
			"dart --version",
			null,
		null},
		{ "meson-lsp", "meson-lsp,--lsp", "meson,build",
			"meson-lsp --help",
			null,
			"suprapack add meson-lsp --yes"},
		{ "clangd", "clangd", "c,cpp,tpp",
			"clangd --version",
			null,
			"suprapack add clangd16 --yes"},
		{ "ccls", """ccls,--init={"cache": {"directory": "/tmp/ccls-cache_$USER"}}""", "c,cpp,tpp",
			"ccls --version",
			null,
			"suprapack add ccls --yes"},
		{ "c3lsp", "c3lsp", "c3,c3i",
			"c3lsp --version",
			null,
			"suprapack add c3lsp --yes"},
		{"vim-lsp", "vim-language-server,--stdio", "vim,vi",
			null,
			null,
			"npm install -g vim-language-server"},
		{ "rust-analyzer", "rust-analyzer", "rust,rs",
			"rust-analyzer --version",
			null,
			"suprapack add rust-analyzer --yes"},
		{ "lua-lsp", "lua-language-server", "lua",
			"lua-language-server --version",
			null,
			"suprapack add lua-language-server --yes"},
		{ "typescript-lsp", "typescript-language-server,--stdio", "ts,js,jsx,tsx,typescript,javascript",
			"typescript-language-server --version",
			null,
			"npm install -g typescript-language-server typescript"},
		{"yaml-lsp", "yaml-language-server,--stdio", "yaml,yml",
			null,
			null,
			"npm install -g yaml-language-server"},
		{ "json-lsp", "vscode-json-languageserver,--stdio", "json",
			null,
			null,
			"npm install -g vscode-json-languageserver"},
		{ "html-lsp", "html-languageserver,--stdio", "html",
			null,
			null,
			"npm install -g vscode-html-languageserver-bin"},
		{"css-lsp", "css-languageserver,--stdio", "css",
			null,
			null,
			"npm install -g vscode-css-languageserver-bin"},
		{ "php-lsp", "intelephense,--stdio", "php",
			null,
			null,
			"suprapack add php-language-server --yes"},// TODO
		{ "vue3", "vue-language-server", "vue,js,ts",
			"vue-language-server --version",
			null,
			"npm install -g @vue/language-server"},
	};

	public static HashTable<string, Lsp?> is_loaded {
		get {
			if (_is_loaded == null) {
				_is_loaded = new HashTable<string, Lsp?> (str_hash, str_equal);
			}
			return _is_loaded;
		}
	}
	private static HashTable<string, Lsp?>? _is_loaded = null;
	private static StringBuilder _bs;
	private static StringBuilder bs {
		get {
			if (_bs == null) {
				_bs = new StringBuilder ();
			}
			return _bs;
		}
	}
}

public struct Support {
	string allowed;
	string package_name;
	string bundle;
	string filetype;
}

public class SupportLang {
	public const Support[] all_packages = {
		{ "c3,c3i", "plugin-lang-c3", "lang-c3", "c3"},
		{ "vala,vapi", "plugin-lang-vala", "lang-vala", "vala"},
	};

	public static Support? get_package_possible (string file) {
		if (is_loaded[file] != null)
			return null;

		foreach (Support support in all_packages) {
			if (file in support.allowed.split (","))
			{
				if (support.package_name in suprapack_list_plugin) {
					foreach (var filetype in support.allowed.split (",")) {
						is_loaded[filetype] = support;
					}
					printerr ("The package is ever installed.. skip\n");
					return null;
				}
				return support;
			}
		}
		return null;
	}


	public static void install_package (string package_name) {
		foreach (var support in SupportLang.all_packages) {
			if (support.package_name == package_name) {
				string dev_null;
				int wait_status;
				Process.spawn_command_line_sync ("suprapack install " + support.package_name + " --yes", out dev_null, out dev_null, out wait_status);
				foreach (var filetype in support.allowed.split (",")) {
					is_loaded[filetype] = support;
				}
				print ("LoadBundle: %s %s\n", support.bundle, support.filetype);
				break;
			}
		}
	}



	private static HashTable<string, Support?>? _is_loaded = null;
	private static HashTable<string, Support?> is_loaded {
		get {
			if (_is_loaded == null) {
				_is_loaded = new HashTable<string, Support?> (str_hash, str_equal);
			}
			return _is_loaded;
		}
	}

}
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
		uint8 buffer3[128];
		unowned string lsp_name = (string)buffer1;
		unowned string package_name = (string)buffer2;
		message.scanf ("Install: %s %s", buffer1, buffer2);
		if (lsp_name != "null")
		{
			foreach (var lsp in LspServer.all_servers) {
				if (lsp.name == lsp_name) {
					string dev_null;
					int wait_status;
					Process.spawn_command_line_sync (lsp.command_help, out dev_null, out dev_null, out wait_status);
					if (wait_status != 0) {
						print ("InstallError: %s\n", lsp.command_help);
						return;
					}
					unowned string? lsp_str = LspServer.get_from_lsp (lsp);
					print ("LspGetServer@#@%s\n", lsp_str);
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
