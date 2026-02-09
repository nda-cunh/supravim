namespace Cfg {
	/**
	 * save_config create a file with the current configuration to cfg_fpath 
	 **/
	public void save_config () throws Error {
		var bs = new StringBuilder.sized (2048);
		try {
			var regex = new Regex("""^[#][=]{22}?[ ]\bYOUR CONFIG\b[ ][=]{23}\n(.*?)\n#={58}""", MULTILINE | DOTALL);
			MatchInfo info;
			string contents;
			FileUtils.get_contents (rc_path, out contents);
			bs.append ("__YOUR_CONFIG__\n");
			if (regex.match(contents, 0, out info))
				bs.append (info.fetch(1));
		}
		catch (Error e) {
			bs.append ("__YOUR_CONFIG__\n");
		}
		FileUtils.set_contents (cfg_fpath, bs.str);
	}

	/**
	 * Apply the configuration from the cfg_fpath file.
	 * This method reads the configuration file, parses each line,
	 * and updates the corresponding options in the system.
	 * @throws Error If there is an issue reading the file or parsing the contents.
	 */
	public void apply_config () throws Error {
		string cfg_content;
		FileUtils.get_contents (cfg_fpath, out cfg_content);

		string vimrc_content;
		FileUtils.get_contents (rc_path, out vimrc_content);
		var sb = new StringBuilder(vimrc_content);

		add_your_config (cfg_content, sb);

		FileUtils.set_contents (rc_path, sb.str);
	}

	private void add_your_config (string contents, StringBuilder sb) {
		// remove old yourconfig in ~/.vimrc (file_contents)
		var idx = sb.str.last_index_of ("#====================== YOUR CONFIG =======================");
		if (idx != -1)
			sb.len = idx;
		// get the contents of __YOUR_CONFIG__ in cfg_fpath
		idx = contents.index_of ("__YOUR_CONFIG__");
		unowned string ptr = contents.offset (idx + 16);
		sb.append ("#====================== YOUR CONFIG =======================\n");
		if (ptr != "") {
			sb.append (ptr);
			sb.append_c ('\n');
		}
		sb.append ("#==========================================================\n");
	}

}
