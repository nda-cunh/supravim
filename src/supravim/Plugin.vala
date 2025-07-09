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

	public bool remove (string url) throws Error {
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
				(?<url>\S+)
				[ ]
				(?<name>\S+)""", RegexCompileFlags.EXTENDED);
		string	[]result = contents.split ("\n");
		for (int i = 0; i < result.length; i++) {
			string	tmp = result[i];
			if (result[i].index_of (url) != -1) {
				if (regex.match (tmp, 0, out info)) {
					var actual_url = info.fetch_named("url");
					var name = info.fetch_named ("name");
					if (url != actual_url)
						new_contents.append (tmp);
					else {
						int	wait;
						Process.spawn_command_line_sync (@"rm -rf $HOME/.vim/bundle/$name", null, null, out wait);
						if (wait != 0)
							throw new SpawnError.FAILED("git return %d", wait);
						
					}
				}
			}
			else
				new_contents.append (tmp);
		}
		FileUtils.set_contents (filename, new_contents.str);
		return true;
	}
}
