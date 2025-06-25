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

	private const GLib.OptionEntry[] options = {
		{ "status", 's',		NONE, 		NONE,			ref is_status,		"Display status of your supravim config.",	null },
		{ "version", 'v',		NONE, 		NONE,			ref is_version,		"Give your supravim version",				null },
		{ "update", '\0',		NONE, 		NONE,			ref is_update,		"Update supravim",							null },
		{ "uninstall", '\0',	NONE, 		NONE,			ref is_uninstall,	"Uninstall supravim",						null },
		{ "theme", 't',			NONE, 		STRING,			ref theme,			"Set theme.",								null },
		{ "disable", 'd',		NONE, 		STRING_ARRAY,	ref disable,		"Disable options.",							"optA[,optB]"},
		{ "enable", 'e',		NONE, 		STRING_ARRAY,	ref enable,			"Enable options.",							"optA[,optB]"},
		{ "set", 'S',			NONE, 		STRING_ARRAY,	ref variable_set,	"Set plugin variables.",					"optA[,optB]"},
		{ "print-options", 0,	HIDDEN, 	NONE,			ref print_opts,		"Print available options.",					null },
		{ "print-themes", 0,	HIDDEN, 	NONE,			ref print_themes,	"Print available themes.",					null },
		{ null }
	};

	
	public static bool run () throws Error {
		if (is_version) {
			print ("Supravim version %s\n", Config.VERSION);
			return true;
		}
		else if (is_update)
			return Process.spawn_command_line_sync ("suprapack update");
		else if (is_uninstall)
			return Process.spawn_command_line_sync ("suprapack remove supravim");

		foreach (unowned string str in disable)
			Modificator.disable (str);

		foreach (unowned string str in enable)
			Modificator.enable (str);


		if (theme != null)
			return Theme.change (theme);
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
		cfg_fpath = @"$(HOME)/.local/share/supravim/supravim.cfg";
		rc_path = @"$(HOME)/.vimrc";
		try {
			// Init options Entry 
			var opt_context = new OptionContext ("- OptionContext example");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);

			// Get options object
			var sp = General.get();
			print ("Supravim Options:\n");
			foreach (unowned string key in sp.get_keys ()) {
				unowned Element elem = sp[key];
				print ("{\033[35m%s\033[0m} = {\033[36m%s\033[0m} {%s}\n", elem.name, elem.value, elem.comment ?? "(null)");
			}
			return (run () == true ? 0 : -1);
		}
		catch (Error e) {
			printerr ("Error parsing option: %s\n", e.message);
			return -1;
		}
	}
}
