
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

	public void init () {
		HOME      = Environment.get_home_dir ();
		cfg_dir   = @"$(HOME)/.local/share/supravim";
		cfg_fpath = @"$(cfg_dir)/supravim.cfg";
		rc_path   = @"$(HOME)/.vimrc";
	}

}
