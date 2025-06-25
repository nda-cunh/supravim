namespace General {
	private static HashTable<unowned string, Element>? _sv_options = null;

	public static unowned HashTable<unowned string, Element> get() throws Error {
		if (_sv_options == null) {
			_sv_options = new HashTable<unowned string, Element> (str_hash, str_equal);
			init_options ();
		}
		return _sv_options;
	}

	/**
	 * Initialize the options from the configuration file and any
	 * plugin files found in the plugin directory.
	 * Load The Directory is ~/.vim/plugin/ 
	 * Load ~/.vimrc
	 */
	private static void init_options () throws Error {
		unowned string? name;
		var bs = new StringBuilder.sized (64);
		var plugin_dir = @"$(HOME)/.vim/plugin/";

		var dir = Dir.open (plugin_dir);

		load_options_from_file (rc_path);

		while ((name = dir.read_name ()) != null) {
			if (name.has_suffix (".vim")) {
				try {
					bs.len = 0;
					bs.append (plugin_dir);
					bs.append (name);
					load_options_from_file (bs.str);
				}
				catch (Error e) {
					warning ("Error loading options from file %s: %s", name, e.message);
				}
			}
		}
	}

	/**
	 * Load all options from the given vim's file.
	 * @param file The file to load options from.
	 * @throws Error if the file cannot be read or parsed.
	 */
	private static void load_options_from_file (string file) throws Error {
		MatchInfo info;
		string contents;

		FileUtils.get_contents (file, out contents);
		var regex = new Regex ("""^g:sp_\S* [=] .*$""", GLib.RegexCompileFlags.MULTILINE);

		if (regex.match (contents, 0, out info)) {
			do {
				int start, end;
				info.fetch_pos (0, out start, out end);
				contents.data[end] = '\0';
				try {
					var element = new Element(contents.offset(start));
					_sv_options[element.name] = (owned)element;
				}
				catch (ErrorQuote e) {
					warning ("File: %s Error %s", file, e.message);
				}
				contents.data[end] = '\n';
			} while (info.next ());
		}
	}
}

