namespace Theme {
	/**
	 * Simple function to change the theme of supravim.
	 * modifies the `~/.vimrc` file to set the theme.
	 * format of the theme is: <theme_name>[-<background>]
	 * @param new_theme The name of the theme to set.
	 * @return true if the theme was changed successfully, false otherwise.
	 * @throws Error if there was an issue reading or writing the file.
	 **/
	public bool change (string new_theme) throws Error {
		var theme_bg = "dark";
		var index_of_dash = new_theme.last_index_of_char ('-');

		string theme;
		if (index_of_dash == -1)
			theme = new_theme;
		else
		{
			theme = new_theme[0:index_of_dash];
			theme_bg = new_theme[index_of_dash + 1:];
		}

		Options.update_value ("theme", theme);
		return true;
	}


	public bool print_all_themes() throws Error {
		var dir = Dir.open (@"$(HOME)/.vim/colors/");
		unowned string? name;

		while ((name = dir.read_name ()) != null) {
			if (name.has_suffix (".vim")) {
				print ("%s ", name[:-4]);
			}
		}
		return true;
	}
}
