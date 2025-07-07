namespace Plugin {
	public bool add (string url) throws Error {
		int	idx = url.last_index_of_char ('/');
		string name = url[idx + 1:];

		name._delimit (".", '\0');
		Process.spawn_command_line_sync(@"git clone --depth=1 $url $HOME/.vim/bundle/$name", null, null, null);
		string contents;
		string filename = Environment.get_current_dir () + "/supravim.cfg";
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
}
