namespace Plugin {
	public bool add (string url) throws Error {
		int wait;
		int	idx = url.last_index_of_char ('/');
		string name = url[idx + 1:];

		name._delimit (".", '\0');
		Process.spawn_command_line_sync(@"git clone --depth=1 $url $HOME/.vim/bundle/$name", null, null, out wait);
		if (wait != 0)
			throw new SpawnError.FAILED("git return %d", wait);
		string contents;
		string filename = Environment.get_user_config_dir () + "/supravim.cfg";
		try {
			FileUtils.get_contents (filename, out contents);
		}
		catch (Error e) {
			contents = "";
		}
		if (contents.index_of (url) == -1)
			FileUtils.set_contents (filename, contents + @"E $url $name\n");
		return true;
	}

	public bool remove (string name) throws Error {
		string contents; 
		string filename = Environment.get_user_config_dir () + "/supravim.cfg";
		try {
			FileUtils.get_contents (filename, out contents);
		}
		catch (Error e) {
			contents = "";
		}
		MatchInfo	info;
		var new_contents = new StringBuilder();
		var regex = new Regex ("""(E|D)
				[ ]
				\S+
				[ ]
				(?<name>\S+)""", RegexCompileFlags.EXTENDED);
		string	[]result = contents.split ("\n");
		for (int i = 0; i < result.length; i++) {
			if (result[i].index_of (name) != -1) {
				if (regex.match (result[i], 0, out info)) {
					var actual_name = info.fetch_named ("name");
					if (name != actual_name) {
						if (result[i][0] != '\0' && result[i][result[i].length - 1] != '\n')
							new_contents.append (@"$(result[i])\n");
						else if (result[i][0] != '\0')
							new_contents.append (result[i]);
					}
					else {
						int	wait;
						Process.spawn_command_line_sync (@"rm -rf $HOME/.vim/bundle/$actual_name", null, null, out wait);
						if (wait != 0)
							throw new SpawnError.FAILED("git return %d", wait);
					}
				}
			}
			else {
				if (result[i][0] != '\0' && result[i][result[i].length - 1] != '\n')
					new_contents.append (@"$(result[i])\n");
				else if (result[i][0] != '\0')
					new_contents.append (result[i]);
			}
		}
		FileUtils.set_contents (filename, new_contents.str);
		return true;
	}

	public bool enable_disable(string name, bool enable) throws Error {
		string new_status = "D", old_status = "E";
		if (enable) {
			new_status = "E";
			old_status = "D";
		}
		string contents; 
		string filename = Environment.get_user_config_dir () + "/supravim.cfg";
		try {
			FileUtils.get_contents (filename, out contents);
		}
		catch (Error e) {
			contents = "";
		}
		MatchInfo	info;
		var new_contents = new StringBuilder();
		var regex = new Regex ("""(?<status>(E|D))
				[ ]
				(?<url>\S+)
				[ ]
				(?<name>\S+)""", RegexCompileFlags.EXTENDED);
		string	[]result = contents.split ("\n");
		for (int i = 0; i < result.length; i++) {
			if (result[i].index_of (name) != -1) {
				if (regex.match (result[i], 0, out info)) {
					var actual_status = info.fetch_named ("status");
					var actual_url = info.fetch_named ("url");
					var actual_name = info.fetch_named ("name");
					if (name == actual_name) {
						if (actual_status == old_status)
							new_contents.append (@"$new_status $actual_url $name\n");
						else if (result[i][result[i].length - 1] != '\n')
							new_contents.append (@"$(result[i])\n");
						else
							new_contents.append (result[i]);
					}
				}
			}
			else {
				if (result[i][0] != '\0' && result[i][result[i].length - 1] != '\n')
						new_contents.append (@"$(result[i])\n");
				else if (result[i][0] != '\0')
					new_contents.append (result[i]);
			}
		}
		FileUtils.set_contents (filename, new_contents.str);
		return true;
	}
}
