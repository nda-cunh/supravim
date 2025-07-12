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
		var reg_theme_bg = new Regex("""^set background=(?:dark|light)""", RegexCompileFlags.MULTILINE);

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

		Modificator.update_value ("theme", theme, rc_path, OptionType.STRING, "A cute theme color");

		string contents;
		FileUtils.get_contents (rc_path, out contents);
		var len = contents.length;

		contents = reg_theme_bg.replace (contents, len, 0, "set background=" + theme_bg);

		print ("Setting theme to: \033[96;1m%s %s\033[m\n", theme, theme_bg);

		FileUtils.set_contents (rc_path, contents);
		return true;
	}
}
