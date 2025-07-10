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
	private static string? theme = null;
	private static string? add_plugin = null;
	private static string? remove_plugin = null;
	private static string? enable_plugin = null;
	
	private static bool save_config = false;
	private static bool apply_config = false;

	private const GLib.OptionEntry[] options = {
		{ "status", 's',		NONE, 		NONE,			ref is_status,		"Display status of your supravim config.",	null },
		{ "version", 'v',		NONE, 		NONE,			ref is_version,		"Give your supravim version",				null },
		{ "update", '\0',		NONE, 		NONE,			ref is_update,		"Update supravim",							null },
		{ "uninstall", '\0',	NONE, 		NONE,			ref is_uninstall,	"Uninstall supravim",						null },
		{ "theme", 't',			NONE, 		STRING,			ref theme,			"Set theme.",								null },
		{ "add-plugin", '\0',	NONE, 		STRING,			ref add_plugin,		"Add plugin.",								null },
		{ "remove-plugin", '\0',NONE, 		STRING,			ref remove_plugin,	"Remove plugin.",							null },
		{ "enable-plugin", '\0',NONE, 		STRING,			ref enable_plugin,	"Enable plugin.",							null },
		{ "disable", 'd',		NONE, 		STRING_ARRAY,	ref disable,		"Disable options.",							"optA[,optB]"},
		{ "enable", 'e',		NONE, 		STRING_ARRAY,	ref enable,			"Enable options.",							"optA[,optB]"},
		{ "set", 'S',			NONE, 		STRING_ARRAY,	ref variable_set,	"Set plugin variables.",					"optA[,optB]"},
		{ "print-options", 0,	HIDDEN, 	NONE,			ref print_opts,		"Print available options.",					null },
		{ "print-themes", 0,	HIDDEN, 	NONE,			ref print_themes,	"Print available themes.",					null },
		{ "save-config", 0,		HIDDEN, 	NONE,			ref save_config,	"Just save the config actual",				null },
		{ "apply-config", 0,	HIDDEN, 	NONE,			ref apply_config,	"Just apply the config actual",				null },
		{ null }
	};

	
	public static bool run () throws Error {
		if (is_version) {
			print ("Supravim version %s\n", Config.VERSION);
			return true;
		}
		else if (save_config)
			Cfg.save_config ();
		else if (apply_config)
			Cfg.apply_config ();
		else if (is_update)
			return Process.spawn_command_line_sync ("suprapack update");
		else if (is_uninstall)
			return Process.spawn_command_line_sync ("suprapack remove supravim");
		else if (is_status) {
			print_status ();
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

		if (theme != null)
			return Theme.change (theme);
		if (add_plugin != null)
			return Plugin.add (add_plugin);
		if (remove_plugin != null)
			return Plugin.remove (remove_plugin);
		if (enable_plugin != null)
			return Plugin.enable (enable_plugin);
		return true;
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

			return (run () == true ? 0 : -1);
		}
		catch (Error e) {
			printerr ("Error parsing option: %s\n", e.message);
			return -1;
		}
	}
}
