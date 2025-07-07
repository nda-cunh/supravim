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

