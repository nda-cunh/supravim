namespace Supravim.Theme {

	public void change (string new_theme) throws Error {
		string theme;
		int index_of_dash = new_theme.last_index_of_char ('-');
		if (index_of_dash == -1)
			theme = new_theme;
		else
			theme = new_theme[0:index_of_dash];
		Options.update_value ("theme", theme);
	}

	public List<string> get_all () throws Error {
		var result = new List<string> ();
		var dir = Dir.open (@"$(HOME)/.vim/colors/");
		unowned string? name;
		while ((name = dir.read_name ()) != null) {
			if (name.has_suffix (".vim"))
				result.append (name[0 : name.length - 4]);
		}
		return result;
	}
}
