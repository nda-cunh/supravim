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

	public static Lsp[]? get_lsp_possible (string name) {
		if (name in is_loaded)
			return null;

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
		is_loaded[server.name] = server;
		return bs.str;
	}


	public const Lsp[] all_servers = {
		{ "asm", "asm-lsp", "s,asm,nasm",
			null,
			"install it with your package manager or with\r~~\rsuprapack add asm-lsp\rClick here to install it",
			"suprapack add asm-lsp"},
		{ "blueprint", "blueprint-compiler,lsp", "blp,bp,blueprint",
			"blueprint-compiler --version",
			"install it with your package manager or with\r~~\rsuprapack add asm-lsp\rClick here to install it",
			"suprapack add blueprint-compiler"},
		{ "pylsp", "pyls", "py,python",
			"pylsp -h",
			"install it with pip or pipx\r~~\rpip install python-lsp-server[all]\rClick here to install it",
			"pip install python-lsp-server[all]"},
		{"kotlin-lsp", "kotlin-language-server", "kt,kts,kotlin",
			null,
			"install it with your package manager or with\r~~\rsuprapack add kotlin-language-server\rClick here to install it",
			"suprapack add kotlin-language-server"},
		{ "vls", "vala-language-server", "vala,vapi",
			"vala-language-server --help",
			"install it with your package manager or with\r~~\rsuprapack add vala-language-server\rClick here to install it",
			"suprapack add vala-language-server"},
		{ "bash-lsp", "bash-language-server,start", "sh,bash",
			"bash-language-server --version",
			"install it with your package manager or with\r~~\rnpm i -g bash-language-server\rClick on me",
			"xdg-open https://github.com/bash-lsp/bash-language-server"},
		{ "dart-lsp", "dart,language-server", "dart",
			"dart --version",
			"Just install dart !",
		null},
		{ "meson-lsp", "meson-lsp,--lsp", "meson,build",
			"meson-lsp --help",
			null,
			"suprapack add meson-lsp"},
		{ "clangd", "clangd", "c,cpp,tpp",
			"clangd --version",
			null,
			"suprapack add clangd16"},
		{ "ccls", """ccls,--init={"cache": {"directory": "/tmp/ccls-cache_$USER"}}""", "c,cpp,tpp",
			"ccls --version",
			null,
			"suprapack add ccls"},
			{ "c3lsp", "c3lsp", "c3,c3i",
			"c3lsp --version",
			null,
			null},
		{ "rust-analyzer", "rust-analyzer", "rust,rs",
			"rust-analyzer --version",
			null,
			"suprapack add rust-analyzer"},
		{ "lua-lsp", "lua-language-server", "lua",
			"lua-language-server --version",
			"Install it with your package manager or with suprapack",
			"suprapack add lua-language-server"},
		{ "typescript-lsp", "typescript-language-server,--stdio", "ts,js,jsx,tsx,javascript",
			"typescript-language-server --version",
			"npm install -g typescript-language-server typescript",
			"npm install -g typescript-language-server typescript"},
		{ "vue3", "vue-language-server", "vue,js,ts",
			"vue-language-server --version",
			"install it with your package manager or with\r~~\rnpm i -g @volar/vue-language-server\rClick here to install it",
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

public void getInputRaw (string message) {
	uint8 buffer1[1024];
	unowned string str1 = (string)buffer1;

	printerr ("GetFromServer: %s\n", message);

	if (message.has_prefix ("OpenFile: ")) {
		message.scanf ("OpenFile: %s", buffer1);
		// Check if an Lsp exist for this file
		var possible_lsp = LspServer.get_lsp_possible (str1);
		if (possible_lsp == null) {
			printerr ("LspServer: %s is ever loaded\n", str1);
			return;
		}

		if (possible_lsp.length == 0) {
			printerr ("No Lsp found for %s\n", str1);
			return;
		}

		// Iterate all Lsp possible
		foreach (Lsp lsp in possible_lsp) {
			// Check if the command exists
			if (LspServer.if_command_exists (lsp.command)) {
				if (lsp.test_command != null) {
					int exit_code = -1;
					try {

						string devnull;
						Process.spawn_command_line_sync (lsp.test_command, out devnull, out devnull, out exit_code);
						if (exit_code != 0)
							throw new SpawnError.FAILED("");
					}
					catch (Error e) {
						print ("LspServerError:the LSP exist but the command\r~~\r%s\r~~\rfailed and returns error code [%d]\n", lsp.command, exit_code);
						return ;
					}
				}
				unowned string? lsp_str = LspServer.get_from_lsp (lsp);
				print ("LspGetServer@#@%s\n", lsp_str);
				return;
			}
		}

		var bs = new StringBuilder ("No LSP found for ");
		bs.append (str1);
		bs.append ("\r");
		bs.append ("With your package manager, install  :");

		foreach (Lsp lsp in possible_lsp) {
			var cmd = LspServer.get_command (lsp.command);
			bs.append ("\r~~\r");
			bs.append (cmd);
			bs.append_c (' ');
			if (lsp.help != null) {
				bs.append (lsp.help);
			}
			bs.append ("\r");
		}

		print ("LspError: %s\n", bs.str);


	}

	if (message == "todo\n")
	{
		print ("todo:4\n");
		print ("> main.c:3\n");
		print ("> toto.c:1\n");
	}
}

public async int main (string[] args) {
	var monitor = new MyMonitor (args[1]);
	monitor.onStdin.connect (getInputRaw);
	
	yield monitor.run ();
	return 0;
}
