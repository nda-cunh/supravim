namespace Supravim.Options {

	private string vim_string (string s) throws Error {
		for (int i = 0; i < s.length; i++) {
			if (s[i] < 0x20 || s[i] == 0x7f)
				throw new SupravimError.BAD_VALUE ("Invalid control character in '%s'".printf (s.escape ()));
		}
		return "\"" + s.replace ("\\", "\\\\").replace ("\"", "\\\"") + "\"";
	}

	public void update_value (string key, string value) throws Error {
		string out_str;
		string err_str;
		string call = "call supraconfig#UpdateWithStringWithoutApply(" + vim_string (key) + ", " + vim_string (value) + ")";
		Process.spawn_sync (null, {"vim", "-es", "-u", rc_path, "-c", call, "-c", "q"}, null, SpawnFlags.SEARCH_PATH, null, out out_str, out err_str, null);
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
