namespace Supravim.Theme {

	public void change (string new_theme) throws Error {
		Options.update_value ("theme", new_theme);
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
