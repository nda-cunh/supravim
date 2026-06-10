using Supravim;

private const string R  = "\033[0m";
private const string B  = "\033[1m";
private const string GR = "\033[32m";
private const string RE = "\033[31m";
private const string BL = "\033[34m";
private const string YE = "\033[33m";
private const string CY = "\033[96m";

public class Main {
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? disable = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? enable = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? variable_set = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[]? reset = null;

	private static bool is_version = false;
	private static bool is_status = false;
	private static bool print_opts = false;
	private static bool print_opts_switchable = false;
	private static bool print_themes = false;
	private static bool print_plugins = false;
	private static bool print_groups  = false;
	private static bool print_supramenu_plugin = false;
	private static bool    list_plugin        = false;
	private static string? list_group         = null;
	private static bool    list_only_pinned   = false;
	private static bool    list_only_disabled = false;
	private static string? theme = null;
	private static string? add_plugin = null;
	private static string? remove_plugin = null;
	private static string? enable_plugin = null;
	private static string? disable_plugin = null;
	private static string? update_plugin = null;
	private static bool update_plugin_all   = false;
	private static string? pin_plugin          = null;
	private static string? unpin_plugin        = null;
	private static string? add_group_plugin    = null;
	private static string? remove_group_plugin = null;
	private static string? enable_group_plugin = null;
	private static string? disable_group_plugin = null;

	private static bool save_config = false;
	private static bool apply_config = false;

	private static string? _list_options = null;

	private const GLib.OptionEntry[] options = {
		{ "status", 's',		NONE, 		NONE,			ref is_status,		"Display status of your supravim config.",	null },
		{ "version", 'v',		NONE, 		NONE,			ref is_version,		"Give your supravim version",				null },
		{ "list-plugin",      '\0', NONE, NONE,   ref list_plugin,        "List plugins.",                           null },
		{ "group",            '\0', NONE, STRING, ref list_group,         "Filter list by group (use with --list-plugin).", null },
		{ "only-pinned",      '\0', NONE, NONE,   ref list_only_pinned,   "Show only pinned plugins.",               null },
		{ "only-disabled",    '\0', NONE, NONE,   ref list_only_disabled, "Show only disabled plugins.",             null },
		{ "theme", 't',			NONE, 		STRING,			ref theme,			"Set theme.",								null },
		{ "add-plugin", '\0',	NONE, 		STRING,			ref add_plugin,		"Add plugin.",								null },
		{ "remove-plugin", '\0',NONE, 		STRING,			ref remove_plugin,	"Remove plugin.",							null },
		{ "enable-plugin", '\0',NONE, 		STRING,			ref enable_plugin,	"Enable plugin.",							null },
		{ "disable-plugin", '\0',NONE, 		STRING,			ref disable_plugin,	"Disable plugin.",							null },
		{ "update-plugin", '\0',NONE, 		STRING,			ref update_plugin,	"Update plugin.",							null },
		{ "update-plugin-all", '\0',NONE, 	NONE,			ref update_plugin_all,	"Update all plugins.",					null },
		{ "pin-plugin",   '\0', NONE, STRING, ref pin_plugin,          "Pin plugin to its current commit.",        null },
		{ "unpin-plugin", '\0', NONE, STRING, ref unpin_plugin,        "Unpin plugin (allow updates again).",      null },
		{ "add-group",    '\0', NONE, STRING, ref add_group_plugin,    "Add plugin to group (<plugin>:<group>).",  null },
		{ "remove-group", '\0', NONE, STRING, ref remove_group_plugin, "Remove plugin from group (<plugin>:<group>).", null },
		{ "enable-group", '\0', NONE, STRING, ref enable_group_plugin, "Enable all plugins in a group.",          null },
		{ "disable-group",'\0', NONE, STRING, ref disable_group_plugin,"Disable all plugins in a group.",         null },
		{ "disable", 'd',		NONE, 		STRING_ARRAY,	ref disable,		"Disable options.",							"optA[,optB]"},
		{ "enable", 'e',		NONE, 		STRING_ARRAY,	ref enable,			"Enable options.",							"optA[,optB]"},
		{ "reset", 'r',			NONE, 		STRING_ARRAY,	ref reset,			"Reset options to their default values.",	"optA[,optB]"},
		{ "set", 'S',			NONE, 		STRING_ARRAY,	ref variable_set,	"Set plugin variables.",					"optA[,optB]"},
		{ "print-options", 0,	HIDDEN, 	NONE,			ref print_opts,		"Print available options.",					null },
		{ "print-options-switchable", 0,	HIDDEN, 	NONE,			ref print_opts_switchable,		"Print switchable available options.",		null },
		{ "print-themes", 0,	HIDDEN, 	NONE,			ref print_themes,	"Print available themes.",					null },
		{ "print-plugins", 0,	HIDDEN, 	NONE,			ref print_plugins,	"",				null },
		{ "print-groups",  0,	HIDDEN, 	NONE,			ref print_groups,	"",				null },
		{ "save-config", 0,		HIDDEN, 	NONE,			ref save_config,	"",				null },
		{ "apply-config", 0,	HIDDEN, 	NONE,			ref apply_config,	"",				null },
		{ "supramenu_pl", 0,	HIDDEN, 	NONE,			ref print_supramenu_plugin,	"",		null },
		{ "_list-options", '\0', OptionFlags.HIDDEN, OptionArg.STRING, ref _list_options, null, null },
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

	public static void ft_print_supramenu_plugin () throws Error {
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
				plugins += SupraVimPlugin (name, version, comment, installed);
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
		max_name_len += 2;
		max_version_len += 2;
		foreach (unowned var plugin in plugins) {
				print ("• %-*s %*s   %s %s \n",
				max_name_len, plugin.name,
				max_version_len, plugin.version,
				plugin.installed ? "➕": "❌",
				plugin.comment);
		}
	}

	public static bool? run () throws Error {
		if (_list_options == "zsh") {
			foreach (unowned var entry in options) {
				if (entry.long_name != null && entry.long_name != "list-options" && entry.flags != OptionFlags.HIDDEN)
					stdout.printf("--%s:%s\n", entry.long_name, entry.description ?? "");
			}
			return true;
		}
		else if (_list_options != null) {
			foreach (unowned var entry in options) {
				if (entry.long_name != null && entry.long_name != "list-options" && entry.flags != OptionFlags.HIDDEN)
					print ("--%s\n", entry.long_name);
			}
			return true;
		}
		if (is_version) {
			print ("Supravim version %s\n", Config.VERSION);
			return true;
		}
		if (print_plugins) {
			foreach (var entry in Plugin.get_all ())
				print ("%s\n", entry.name);
			return true;
		}
		if (print_groups) {
			foreach (var g in Plugin.get_all_groups ())
				print ("%s\n", g);
			return true;
		}
		if (print_opts_switchable) {
			Command.print_options_switchable ();
			return true;
		}
		if (print_opts) {
			Command.print_options ();
			return true;
		}
		if (print_themes) {
			foreach (var t in Theme.get_all ())
				print ("%s\n", t);
			return true;
		}
		if (print_supramenu_plugin) {
			ft_print_supramenu_plugin ();
			return true;
		}
		if (save_config) {
			Cfg.save_config ();
			return true;
		}
		if (apply_config) {
			Cfg.apply_config ();
			return true;
		}
		if (is_status) {
			Command.print_status ();
			return true;
		}

		foreach (unowned string str in disable)
			Options.disable (str);
		foreach (unowned string str in reset)
			Options.reset (str);
		foreach (unowned string str in enable)
			Options.enable (str);

		foreach (unowned string str in variable_set) {
			try {
				if (!("=" in str))
					throw new SupravimError.BAD_VALUE("Invalid format. Expected: opt=value");
				string key = str[0:str.index_of_char('=')];
				string v = str[str.index_of_char('=') + 1:];
				Options.update_value(key, v);
			} catch (Error e) {
				warning (e.message);
			}
		}

		if (variable_set.length > 0 || enable.length > 0 || disable.length > 0)
			return true;

		if (theme != null) {
			Theme.change (theme);
			return true;
		}
		if (add_plugin != null) {
			Plugin.add (add_plugin);
			print (B + GR + "Plugin %s added successfully\n" + R, add_plugin);
			return true;
		}
		if (remove_plugin != null) {
			Plugin.remove (remove_plugin);
			print (B + GR + "Plugin %s removed successfully\n" + R, remove_plugin);
			return true;
		}
		if (enable_plugin != null) {
			Plugin.enable (enable_plugin);
			print (B + GR + "Plugin %s enabled\n" + R, enable_plugin);
			return true;
		}
		if (disable_plugin != null) {
			Plugin.disable (disable_plugin);
			print (B + GR + "Plugin %s disabled\n" + R, disable_plugin);
			return true;
		}
		if (update_plugin_all) {
			print (B + "Updating all plugins...\n" + R);
			Plugin.update_all ();
			print (B + GR + "All plugins updated\n" + R);
			return true;
		}
		if (update_plugin != null) {
			Plugin.update (update_plugin);
			print (B + GR + "Plugin %s updated\n" + R, update_plugin);
			return true;
		}
		if (list_plugin)
			return Command.list (list_group, list_only_pinned, list_only_disabled);
		if (pin_plugin != null) {
			string commit = Plugin.pin (pin_plugin);
			print (B + GR + "Plugin %s pinned at %s\n" + R, pin_plugin, commit);
			return true;
		}
		if (unpin_plugin != null) {
			Plugin.unpin (unpin_plugin);
			print (B + GR + "Plugin %s unpinned\n" + R, unpin_plugin);
			return true;
		}
		if (add_group_plugin != null) {
			var parts = add_group_plugin.split (":", 2);
			if (parts.length != 2)
				throw new SupravimError.BAD_VALUE ("Expected format: <plugin>:<group>");
			Plugin.add_group (parts[0], parts[1].strip ());
			print (B + GR + "Plugin %s added to group '%s'\n" + R, parts[0], parts[1].strip ());
			return true;
		}
		if (remove_group_plugin != null) {
			var parts = remove_group_plugin.split (":", 2);
			if (parts.length != 2)
				throw new SupravimError.BAD_VALUE ("Expected format: <plugin>:<group>");
			Plugin.remove_group (parts[0], parts[1].strip ());
			print (B + GR + "Plugin %s removed from group '%s'\n" + R, parts[0], parts[1].strip ());
			return true;
		}
		if (enable_group_plugin != null) {
			int n = Plugin.enable_group (enable_group_plugin);
			print (B + GR + "%d plugin(s) in group '%s' enabled\n" + R, n, enable_group_plugin);
			return true;
		}
		if (disable_group_plugin != null) {
			int n = Plugin.disable_group (disable_group_plugin);
			print (B + GR + "%d plugin(s) in group '%s' disabled\n" + R, n, disable_group_plugin);
			return true;
		}
		return null;
	}

	public static int main (string[] args) {
		Intl.setlocale ();
		Supravim.init ();
		try {
			var opt_context = new OptionContext ("Program to personalize your supravim");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);

			var? result = run ();
			if (result == null) {
				var sb = new StrvBuilder ();
				sb.add ("vim");
				sb.addv(args[1:]);
				Process.spawn_sync (null, sb.end(), Environ.get(), SpawnFlags.SEARCH_PATH + SpawnFlags.CHILD_INHERITS_STDIN, null);
				return 0;
			}
			return result == true ? 0 : 1;
		} catch (Error e) {
			printerr (B + RE + "%s\n" + R, e.message);
			return 1;
		}
	}
}
