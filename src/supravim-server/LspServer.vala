public struct Lsp {
	string name; // the name of the language
	string command;// command separated by ','
	string allowed; // filetype like vala, c, cpp, py, js, ts, lua
	string? test_command; // command to test if the lsp is working
	string? command_help; // help message
}

/**
 * LspServer - A class to manage the Language Server Protocol (LSP) servers
 *
 * This class provides a way to manage and interact with various LSP servers.
 * It includes methods to check if a server is loaded, retrieve server information,
 * and install servers if necessary.
 */
namespace LspServer {
	public const Lsp[] all_servers = {
		{ "asm", "asm-lsp", "s,asm,nasm",
			null,
			"suprapack add asm-lsp --yes"},
		{ "blueprint", "blueprint-compiler,lsp", "blp,bp,blueprint",
			"blueprint-compiler --version",
			"suprapack add blueprint-compiler --yes"},
		{ "pylsp", "pyls", "py,python",
			"pylsp -h",
			"pip install python-lsp-server[all]"},
		{"kotlin-lsp", "kotlin-language-server", "kt,kts,kotlin",
			null,
			"suprapack add kotlin-language-server --yes"},
		{ "vls", "vala-language-server", "vala,vapi",
			"vala-language-server --help",
			"suprapack add vala-language-server --yes"},
		{ "bash-lsp", "bash-language-server,start", "sh,bash",
			"bash-language-server --version",
			"xdg-open https://github.com/bash-lsp/bash-language-server"},
		{ "dart-lsp", "dart,language-server", "dart",
			"dart --version",
			null},
		{ "meson-lsp", "meson-lsp,--lsp", "meson,build",
			"meson-lsp --help",
			"suprapack add meson-lsp --yes"},
		{ "clangd", "clangd", "c,cpp,tpp",
			"clangd --version",
			"suprapack add clangd16 --yes"},
		{ "ccls", """ccls,--init={"cache": {"directory": "/tmp/ccls-cache_$USER"}}""", "c,cpp,tpp",
			"ccls --version",
			"suprapack add ccls --yes"},
		{"jdtls", "jdtls", "java",
			"jdtls --help",
			"suprapack add jdtls --yes"},
		{ "c3lsp", "c3lsp", "c3,c3i",
			"c3lsp --version",
			"suprapack add c3lsp --yes"},
		{ "omnisharp", "omnisharp,-lsp", "cs",
			"omnisharp -h",
			"suprapack add omnisharp dotnet --yes"},
		{"vim-lsp", "vim-language-server,--stdio", "vim,vi",
			null,
			"npm install -g vim-language-server"},
		{ "rust-analyzer", "rust-analyzer", "rust,rs",
			"rust-analyzer --version",
			"suprapack add rust-analyzer --yes"},
		{ "lua-lsp", "lua-language-server", "lua",
			"lua-language-server --version",
			"suprapack add lua-language-server --yes"},
		{ "typescript-lsp", "typescript-language-server,--stdio", "ts,js,jsx,tsx,typescript,javascript",
			"typescript-language-server --version",
			"npm install -g typescript-language-server typescript"},
		{"yaml-lsp", "yaml-language-server,--stdio", "yaml,yml",
			null,
			"npm install -g yaml-language-server"},
		{ "json-lsp", "vscode-json-languageserver,--stdio", "json",
			null,
			"npm install -g vscode-json-languageserver"},
		{ "html-lsp", "html-languageserver,--stdio", "html",
			null,
			"npm install -g vscode-html-languageserver-bin"},
		{"css-lsp", "css-languageserver,--stdio", "css",
			null,
			"npm install -g vscode-css-languageserver-bin"},
		{ "php-lsp", "intelephense,--stdio", "php",
			null,
			"suprapack add php-language-server --yes"}, // TODO
		{ "vue3", "vue-language-server", "vue,js,ts",
			"vue-language-server --version",
			"npm install -g @vue/language-server"},
	};

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

	private bool lsp_is_load(string name) {
		if (get_is_loaded()[name] != null)
			return true;
		return false;
	}

	private Lsp[] get_lsp_possible (string name) {
		Lsp []servers = {};
		foreach (Lsp server in all_servers) {
			if (name in server.allowed.split (",")) {
				servers += server;
			}
		}
		return servers;
	}

	public unowned string get_from_lsp (Lsp server) {
		unowned var bs = get_bs ();
		bs.len = 0;
		bs.printf("%s@#@%s@#@%s", server.name, server.command, server.allowed);
		foreach (var n in server.allowed.split(","))
			get_is_loaded()[n] = server;
		bs.replace ("$USER", Environment.get_user_name ());
		return bs.str;
	}

	public int run_command(string command) {
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
		
		int wait_status = run_command(lsp.command_help);
		if (wait_status != 0) {
			if (Environment.get_variable ("FT_HOOK_NAME") != null) {
				run_command ("suprapack add nodejs --yes");
				wait_status = run_command(lsp.command_help);
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
		int wait_status = run_command(lsp.command_help);
		if (wait_status != 0) {
			throw new ErrorLsp.INSTALL_ERROR ("Error running suprapack command\r(%s)", lsp.command_help);
		}
		else {
			unowned string? lsp_str = LspServer.get_from_lsp (lsp);
			print ("LspGetServer@#@%s\n", lsp_str);
		}
	}

	public void install_lsp (string name) throws Error {
		foreach (unowned var lsp in LspServer.all_servers) {
			if (lsp.name == name) {
				if (lsp.command_help.has_prefix ("npm "))  {
					npm_install (lsp);
				}
				else if (lsp.command_help.has_prefix ("suprapack ")) {
					suprapack_install (lsp);
				}
				else {
					throw new ErrorLsp.INVALID_LSP("(supravim-server) Invalid LSP configuration for '%s'", name);
				}
				return;
			}
		}
		throw new ErrorLsp.NOT_FOUND ("LSP '%s' not found", name);
	}



	public HashTable<string, Lsp?> get_is_loaded() {
		if (_is_loaded == null) {
			_is_loaded = new HashTable<string, Lsp?> (str_hash, str_equal);
		}
		return _is_loaded;
	}
	private HashTable<string, Lsp?>? _is_loaded = null;
	private StringBuilder _bs;
	private unowned StringBuilder get_bs() {
		if (_bs == null) {
			_bs = new StringBuilder ();
		}
		return _bs;
	}
}

public errordomain ErrorLsp {
	NOT_FOUND, // LSP not found
	INSTALL_ERROR, // Error during installation
	COMMAND_ERROR, // Error running command
	INVALID_LSP, // Invalid LSP configuration
	UNKNOWN_ERROR // Unknown error
}
