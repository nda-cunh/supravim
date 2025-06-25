public bool change_theme (string new_theme) throws Error {
	var reg_theme = new Regex("""^g:sp_theme = (?:'.+?'|\"".+?\"")""", RegexCompileFlags.MULTILINE);
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

	string contents;
	FileUtils.get_contents (rc_path, out contents);
	var len = contents.length;

	contents = reg_theme.replace (contents, len, 0, "g:sp_theme = '" + theme + "'");
	contents = reg_theme_bg.replace (contents, len, 0, "set background=" + theme_bg);

	print ("Setting theme to: \033[96;1m%s %s\033[m\n", theme, theme_bg);

	FileUtils.set_contents (rc_path, contents);
	return true;
}
