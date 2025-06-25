public errordomain ErrorQuote {
	UNMATCHED_QUOTE,
}

[Compact]
public class Element {
	public static int search_end(char type, string line, out int comment_end) throws ErrorQuote {
		bool pair = true;
		int end = 0;
		comment_end = -1;

		int i = 0;

		while (line[i] != '\0') {
			if (line[i] == '#' && pair) {
				comment_end = i;
				return end - 1;
			}
			if (line[i] == type) {
				pair = !pair;
				end = i + 1;
			}
			else if (line[i] == '\\') {
				i+=2;
			}
			i++;
		}
		if (pair)
			return end - 1;
		throw new ErrorQuote.UNMATCHED_QUOTE("Unmatched quote in line: %s", line);
	}
	
	public Element(string line) throws ErrorQuote {
		unowned string ptr = line;
		var equal_pos = line.index_of_char ('=') + 1;
		ptr = line.offset (equal_pos + 1);
		// print ("Parsing line: [%c] {{\033[91m%s\033[0m}} PTR: {\033[92m%s\033[0m}\n", ptr[0], line, ptr);
		int end = 0;
		int start = 0;
		int end_comment = -1;
		if (ptr[0] == '\'') {
			end = search_end ('\'', ptr, out end_comment);
			start = 1;
		}
		else if (ptr[0] == '"') {
			end = search_end ('"', ptr, out end_comment);
			start = 1;
		}
		else {
			while (ptr[end].isspace () == false)
				end++;
			end_comment = ptr.index_of_char ('#', end);
		}

		if (end_comment != -1) {
			end_comment += 1;
			while (ptr[end_comment].isspace ())
				end_comment++;
		}


		this.line = line;
		this.line.data[equal_pos - 2] = '\0'; // Temporarily null-terminate the string for easier parsing
		this.name = this.line.offset(5);
		ptr = this.line.offset(equal_pos + 1);
		// Value
		ptr.data[end] = '\0'; // Temporarily null-terminate the value string
		this.value = ptr.offset(start);
		// Comment
		if (end_comment != -1)
			this.comment = ptr.offset(end_comment);
		else
			this.comment = null;
	}

	public string line;
	public string file;
	public unowned string name;
	public unowned string value;
	public unowned string? comment;
}

[Compact]
public class General {
	private static HashTable<unowned string, Element>? _sv_options = null;

	public static unowned HashTable<unowned string, Element> get() throws Error {
		if (_sv_options == null) {
			init_options ();
		}
		return _sv_options;
	}

	private static void init_options () throws Error {
		_sv_options = new HashTable<unowned string, Element> (str_hash, str_equal);
		load_options_from_file (rc_path);
		var bs = new StringBuilder.sized (64);
		var plugin_dir = @"$(HOME)/.vim/plugin/";
		var dir = Dir.open (plugin_dir);
		unowned string? name;

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

	private static void load_options_from_file (string file) throws Error {
		string contents;
		FileUtils.get_contents (file, out contents);

		var regex = new Regex ("""^g:sp_\S* [=] .*$""", GLib.RegexCompileFlags.MULTILINE);
		MatchInfo info;
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

