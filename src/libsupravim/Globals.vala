// Runtime globals — call SupravimLib.init() before using any library function
public string HOME;
public string cfg_dir;
public string cfg_fpath;
public string rc_path;

public const string GREEN   = "\033[32m";
public const string RED     = "\033[31m";
public const string DEFAULT = "\033[;0m";
public const string BOLD    = "\033[;1m";

public errordomain SupravimError {
	BAD_VALUE,
	VIM_CALL,
	NOT_FOUND,
	ALREADY_EXISTS,
	UNKNOWN_ERROR
}

namespace SupravimLib {
	public void init () {
		HOME      = Environment.get_home_dir ();
		cfg_dir   = @"$(HOME)/.local/share/supravim";
		cfg_fpath = @"$(cfg_dir)/supravim.cfg";
		rc_path   = @"$(HOME)/.vimrc";
	}
}
