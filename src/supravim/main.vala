public const string GREEN = "\033[32m";
public const string RED = "\033[31m";
public const string DEFAULT = "\033[;0m";
public const string BOLD = "\033[;1m";
public string HOME;
public string cfg_dir;
public string cfg_fpath;
public string rc_path;

public class Main {
	// Array of strings to hold the options passed from the command line. 
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? disable = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? enable = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? variable_set = null;

	// Boolean Options
	private static bool is_version = false;
	private static bool is_status = false;
	private static bool is_update = false;
	private static bool is_uninstall = false;
	private static bool print_opts = false;
	private static bool print_themes = false;
	private static bool print_plugins = false;
	private static bool print_supramenu_plugin = false;
	private static bool list_plugin = false;
	private static string? theme = null;
	private static string? add_plugin = null;
	private static string? remove_plugin = null;
	private static string? enable_plugin = null;
	private static string? disable_plugin = null;
	private static string? update_plugin = null;
	
	private static bool save_config = false;
	private static bool apply_config = false;

	private const GLib.OptionEntry[] options = {
		{ "status", 's',		NONE, 		NONE,			ref is_status,		"Display status of your supravim config.",	null },
		{ "version", 'v',		NONE, 		NONE,			ref is_version,		"Give your supravim version",				null },
		{ "update", '\0',		NONE, 		NONE,			ref is_update,		"Update supravim",							null },
		{ "uninstall", '\0',	NONE, 		NONE,			ref is_uninstall,	"Uninstall supravim",						null },
		{ "list-plugin", '\0',	NONE, 		NONE,			ref list_plugin,	"List plugin.",								null },
		{ "theme", 't',			NONE, 		STRING,			ref theme,			"Set theme.",								null },
		{ "add-plugin", '\0',	NONE, 		STRING,			ref add_plugin,		"Add plugin.",								null },
		{ "remove-plugin", '\0',NONE, 		STRING,			ref remove_plugin,	"Remove plugin.",							null },
		{ "enable-plugin", '\0',NONE, 		STRING,			ref enable_plugin,	"Enable plugin.",							null },
		{ "disable-plugin", '\0',NONE, 		STRING,			ref disable_plugin,	"Disable plugin.",							null },
		{ "update-plugin", '\0',NONE, 		STRING,			ref update_plugin,	"Update plugin.",							null },
		{ "disable", 'd',		NONE, 		STRING_ARRAY,	ref disable,		"Disable options.",							"optA[,optB]"},
		{ "enable", 'e',		NONE, 		STRING_ARRAY,	ref enable,			"Enable options.",							"optA[,optB]"},
		{ "set", 'S',			NONE, 		STRING_ARRAY,	ref variable_set,	"Set plugin variables.",					"optA[,optB]"},
		{ "print-options", 0,	HIDDEN, 	NONE,			ref print_opts,		"Print available options.",					null },
		{ "print-themes", 0,	HIDDEN, 	NONE,			ref print_themes,	"Print available themes.",					null },
		{ "print-plugins", 0,	HIDDEN, 	NONE,			ref print_plugins,	"",				null },
		{ "save-config", 0,		HIDDEN, 	NONE,			ref save_config,	"",				null },
		{ "apply-config", 0,	HIDDEN, 	NONE,			ref apply_config,	"",				null },
		{ "supramenu_pl", 0,	HIDDEN, 	NONE,			ref print_supramenu_plugin,	"",		null },
		{ null }
	};

	struct SupraVimPlugin {
		public SupraVimPlugin (string name, string version, string comment, bool installed) {
			this.name = name;
			this.version = version;
			this.comment = comment;
			this.installed = installed;
		}
		string name;
		string version;
		string comment;
		bool installed;
	}

	// [installed] plugin-autobear 1.3 [auto generate a compile_commands.json for your project]
	public static void ft_print_supramenu_plugin () {
		var regex = new Regex (""" (?<name>\S+) \s+ (?<version>\S+) \s+ \[(?<Comment>[^\]]+)   """, RegexCompileFlags.EXTENDED);
		print ("-- Supramenu Plugins --\n\n");
		string stdout;
		Process.spawn_command_line_sync ("suprapack search_supravim_plugin", out stdout);
		MatchInfo info;
		var sp = stdout.split ("\n");
		SupraVimPlugin[] plugins = {};
		foreach (unowned string line in sp) {
			bool installed = false;
			if (line.has_prefix ("[installed] ")) {
				line = line.offset (12);
				installed = true;
			}
			if (regex.match(line, 0, out info)) {
				var name = info.fetch_named("name");
				var version = info.fetch_named("version");
				var comment = info.fetch_named("Comment");
				plugins += new SupraVimPlugin (name, version, comment, installed);
			}
		}
		int max_name_len = 0;
		int max_version_len = 0;
		foreach (unowned var plugin in plugins) {
			if (plugin.name.length > max_name_len)
				max_name_len = plugin.name.length;
			if (plugin.version.length > max_version_len)
				max_version_len = plugin.version.length;
		}
		max_name_len += 2; // for padding
		max_version_len += 2; // for padding
		// print all plugins

		foreach (unowned var plugin in plugins) {
				print ("• %-*s %*s   %s %s \n", 
				max_name_len, plugin.name, 
				max_version_len, plugin.version, 
				plugin.installed ? "➕": "❌",
				plugin.comment);
		}
	}
	
	/**
	 * Run arguments based on the options set.
	 */
	public static bool? run () throws Error {
		if (is_version) {
			print ("Supravim version %s\n", Config.VERSION);
			return true;
		}
		if (print_plugins)
			return Plugin.print_all_installed_plugins ();
		if (print_opts) {
			var opts = General.get ();
			foreach (var i in opts) {
				print ("%s ", i.name);
			}
			return true;
		}
		if (print_themes)
			return Theme.print_all_themes ();
		if (print_supramenu_plugin) {
			ft_print_supramenu_plugin ();
			return true;
		}
		else if (save_config) {
			Cfg.save_config ();
			return true;
		}
		else if (apply_config) {
			Cfg.apply_config ();
			return true;
		}
		else if (is_update)
			return Process.spawn_command_line_sync ("suprapack update");
		else if (is_uninstall)
			return Process.spawn_command_line_sync ("suprapack remove supravim");
		else if (is_status) {
			print_status ();
			return true;
		}
		
		foreach (unowned string str in disable) {
			try {
				Modificator.disable (str);
			}
			catch (Error e) {
				warning (e.message);
			}
		}

		foreach (unowned string str in enable) {
			try {
				Modificator.enable (str);
			}
			catch (Error e) {
				warning (e.message);
			}
		}

		foreach (unowned string str in variable_set) {
			try {
				Modificator.set_value (str);
			}
			catch (Error e) {
				warning (e.message);
			}
		}

		if (variable_set.length > 0 || enable.length > 0 || disable.length > 0) {
			return true;
		}
		if (theme != null)
			return Theme.change (theme);
		if (add_plugin != null)
			return Plugin.add (add_plugin);
		if (remove_plugin != null)
			return Plugin.remove (remove_plugin);
		if (enable_plugin != null)
			return Plugin.enable(enable_plugin);
		if (disable_plugin != null)
			return Plugin.disable (disable_plugin);
		if (update_plugin != null)
			return Plugin.update (update_plugin);
		if (list_plugin)
			return Plugin.list ();
		return null;
	}


	/**
	 * Main function to run the supravim application.
	 * Parses command line options and executes the appropriate actions.
	 *
	 * @param args Command line arguments.
	 * @return Exit status code.
	 */
	public static int main (string[] args) {
		Intl.setlocale ();
		HOME = Environment.get_home_dir ();
		cfg_dir = @"$(HOME)/.local/share/supravim";
		cfg_fpath = @"$(cfg_dir)/supravim.cfg";
		rc_path = @"$(HOME)/.vimrc";
		try {
			// Init options Entry 
			var opt_context = new OptionContext ("Program to personalize your supravim");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);

			var? result = run();	
			if (result == null) {
				var sb = new StrvBuilder ();
				sb.add ("vim");
				sb.addv(args[1:]);
				Process.spawn_sync (null, sb.end(), Environ.get(), SpawnFlags.SEARCH_PATH + SpawnFlags.CHILD_INHERITS_STDIN, null);
				return 0;
			}
			else {
				if (result == true) {
					return 0;
				}
				else {
					return 1;
				}
			}
		}
		catch (Error e) {
			printerr ("%s\n", e.message);
			return -1;
		}
	}
}
