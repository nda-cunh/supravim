
namespace Supravim {
	public string HOME;
	public string cfg_dir;
	public string cfg_fpath;
	public string rc_path;

	public errordomain SupravimError {
		BAD_VALUE,
		VIM_CALL,
		NOT_FOUND,
		ALREADY_EXISTS,
		UNKNOWN_ERROR
	}

	private string find_localedir () {
		try {
			string exe = FileUtils.read_link ("/proc/self/exe");
			string prefix = Path.get_dirname (Path.get_dirname (exe));
			string dir = Path.build_filename (prefix, "share", "locale");
			if (FileUtils.test (dir, FileTest.IS_DIR))
				return dir;
		}
		catch (Error e) {
		}
		return LOCALEDIR;
	}

	public void init () {
		Intl.bindtextdomain (GETTEXT_PACKAGE, find_localedir ());
		Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
		Intl.textdomain (GETTEXT_PACKAGE);

		HOME      = Environment.get_home_dir ();
		cfg_dir   = @"$(HOME)/.local/share/supravim";
		cfg_fpath = @"$(cfg_dir)/supravim.cfg";
		rc_path   = @"$(HOME)/.vimrc";
	}

}
