namespace Cfg {
	/**
	 * save_config create a file with the current configuration to cfg_fpath 
	 * The format is as follows:
	 * swap:bool:/home/nda-cunh/.vimrc:false@#@comment
	 * theme:string:/home/nda-cunh/.vimrc:'onedark'@#@
	 **/
	public void save_config () throws Error {
		var bs = new StringBuilder.sized (2048);
		try {

			var lst_all = General.get ();
			foreach (unowned var elem in lst_all) {
				if (elem.type == BOOLEAN) {
					bs.append_printf ("%s:bool:%s:%s@#@%s\n", elem.name, elem.file, elem.value, elem.comment ?? "");
				}
				else if (elem.type == STRING) {
					bs.append_printf ("%s:string:%s:'%s'@#@%s\n", elem.name, elem.file, elem.value, elem.comment ?? "");
				}
			}
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
		string contents;
		FileUtils.get_contents (cfg_fpath, out contents);

		var lines = contents.split ("\n");
		var table = new HashTable<string, StringBuilder> (str_hash, str_equal);

		foreach (unowned string line in lines) {
			if (line == "")
				continue;
			if (line == "__YOUR_CONFIG__")
				break;
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
			var opt_type = OptionType.BOOLEAN;

			if ((file in table) == false) {
				string file_contents;
				FileUtils.get_contents (file, out file_contents);
				table[file] = new StringBuilder (file_contents);
			}
			Modificator.update_value_with_contents (name, value, opt_type, comment, table[file]);
		}

		// Open ~/.vimrc if is not already opened
		if ((rc_path in table) == false) {
			string file_contents;
			FileUtils.get_contents (rc_path, out file_contents);
			table[rc_path] = new StringBuilder (file_contents);
		}
		add_your_config (contents, table[rc_path].str);

		// Write the contents of each file
		foreach (unowned var file in table.get_keys_as_array ()) {
			FileUtils.set_contents (file, table[file].str);
		}
	}

	private string add_your_config (string contents, string file_contents) {
		StringBuilder bs = new StringBuilder.sized (2048);
		// remove old yourconfig in ~/.vimrc (file_contents)
		var idx = file_contents.last_index_of ("#====================== YOUR CONFIG =======================");
		if (idx != -1)
			bs.append_len (file_contents, idx);
		else 
			bs.append (file_contents);
		// get the contents of __YOUR_CONFIG__ in cfg_fpath
		idx = contents.index_of ("__YOUR_CONFIG__");
		unowned string ptr = contents.offset (idx + 16);
		bs.append ("#====================== YOUR CONFIG =======================\n");
		if (ptr != "") {
			bs.append (ptr);
			bs.append_c ('\n');
		}
		bs.append ("#==========================================================\n");
		return (owned)bs.str;
	}

}
