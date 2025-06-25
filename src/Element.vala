public errordomain ErrorQuote {
	UNMATCHED_QUOTE,
}

[Compact]
public class Element {
	/**
	 * Constructs an Element from a line in a file.
	 * The line should be in the format: "g:sp_option = 'value' # comment"
	 * @param line The line to parse.
	 * @throws ErrorQuote.UNMATCHED_QUOTE If there is an unmatched quote in the line.
	 */
	public Element (string line) throws ErrorQuote {
		int equal_pos = line.index_of_char ('=') + 1;
		unowned string ptr = line.offset (equal_pos + 1);
		int begin_comment = -1;
		int end = 0;
		int start = 0;

		// if the value is a string
		if (ptr[0] == '\'' || ptr[0] == '"') {
			end = search_closed_quote (ptr[0], ptr, out begin_comment);
			start = 1;
		}
		else {
			// if the value is a number or boolean
			while (ptr[end].isspace () == false)
				++end;
			begin_comment = ptr.index_of_char ('#', end);
		}

		// Skip space for the comment
		if (begin_comment != -1) {
			begin_comment += 1;
			while (ptr[begin_comment].isspace ())
				++begin_comment;
		}

		// The line is on the Heap (malloc'd)
		this.line = line;
		// PERF Set '\0' at the end of the line
		ptr = this.line.offset(equal_pos + 1);
		this.line.data[equal_pos - 2] = '\0'; 
		ptr.data[end] = '\0';
		// Value
		this.name = this.line.offset(5);
		this.value = ptr.offset(start);
		// Comment
		if (begin_comment != -1)
			this.comment = ptr.offset(begin_comment);
	}

	/**
	 * Searches for the closing quote of a string in a line.
	 * @param type The type of quote to search for (either single or double).
	 * @param line The line to search in.
	 * @param begin_comment Output parameter to store the position of the comment start, if any.
	 * @return The position of the closing quote in the line.
	 * @throws ErrorQuote.UNMATCHED_QUOTE If no matching closing quote is found.
	 */
	private static int search_closed_quote(char type, string line, out int begin_comment) throws ErrorQuote {
		bool pair = true;
		int end = 0;
		int i = 0;
		begin_comment = -1;

		while (line[i] != '\0') {
			if (line[i] == '#' && pair) {
				begin_comment = i;
				return end - 1;
			}
			if (line[i] == type) {
				pair = !pair;
				end = i + 1;
			}
			else if (line[i] == '\\') {
				i += 2;
			}
			++i;
		}
		if (pair)
			return end - 1;
		throw new ErrorQuote.UNMATCHED_QUOTE("Unmatched quote in line: %s", line);
	}
	
	public string line; // The Malloc'd line from the file
	public string file; // The file where this element was found, if applicable
	public unowned string name; // The name of the element, e.g., "g:sp_option"
	public unowned string value; // The value of the element, e.g., "1" or "true"
	public unowned string? comment = null; // The comment after the value, if any
}
