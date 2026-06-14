namespace Supravim.Options {

	public void update_value (string key, string value) throws Error {
		string trash;
		var cmd = "vim -es -u ~/.vimrc -c 'call supraconfig#UpdateWithStringWithoutApply(";
		cmd += "\""+key+"\", \""+value+"\"";
		cmd += ")' -c 'q'";
		Process.spawn_command_line_sync (cmd, out trash, out trash);
	}

	public void reset_value (string key) throws Error {
		var lst = SupraParser.get_from_vim();
		foreach (unowned var opt in lst) {
			if (opt == null) continue;
			if (opt.id == key) {
				update_value (key, opt.default_value);
				return;
			}
		}
		warning ("Option '%s' not found for reset.", key);
	}



	public void reset (string key) throws Error {
		reset_value (key);
	}

	public void disable (string key) throws Error {
		update_value (key, "false");
	}

	public void enable (string key) throws Error {
		update_value (key, "true");
	}
}
