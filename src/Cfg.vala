namespace Cfg {
	/**
	 * save_config create a file with the current configuration to cfg_fpath 
	 * The format is as follows:
	 * swap:bool:/home/nda-cunh/.vimrc:false@#@comment
	 * theme:string:/home/nda-cunh/.vimrc:'onedark'@#@
	 **/
	public void save_config () throws Error {
		var bs = new StringBuilder.sized (2048);

		var lst_all = General.get ();
		foreach (unowned var elem in lst_all) {
			if (elem.type == BOOLEAN) {
				bs.append_printf ("%s:bool:%s:%s@#@%s\n", elem.name, elem.file, elem.value, elem.comment ?? "");
			}
			else if (elem.type == STRING) {
				bs.append_printf ("%s:string:%s:'%s'@#@%s\n", elem.name, elem.file, elem.value, elem.comment ?? "");
			}
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
		string contents;
		FileUtils.get_contents (cfg_fpath, out contents);

		var lines = contents.split ("\n");

		foreach (unowned string line in lines) {
			if (line == "")
				continue;
			int index_collon[4];

			index_collon[0] = line.index_of_char (':');
			index_collon[1] = line.index_of_char (':', index_collon[0] + 1);
			index_collon[2] = line.index_of_char (':', index_collon[1] + 1);
			index_collon[3] = line.index_of ("@#@");

			for (int i = 0; i < 4; ++i) 
				line.data[index_collon[i]] = '\0';
			unowned string name = line.offset (0);
			unowned string file = line.offset (index_collon[1] + 1);
			unowned string value = line.offset (index_collon[2] + 1);
			unowned string? comment;
			if (line.offset (index_collon[3] + 3) == "")
				comment = null;
			else
				comment = line.offset (index_collon[3] + 3);
			// NOTE I dont know why it work but it does
			OptionType opt_type = OptionType.BOOLEAN;

			Modificator.update_value(name, value, file, opt_type, comment);
		}
	}
}
