public const string RESET = "\033[0m";
// public const string BOLD = "\033[1m";
public const string GROUP_COLOR = "\033[1;93m";
public const string NAME_COLOR = "\033[96m";
public const string LORE_COLOR = "\033[98;2m";
public const string VAL_BOOL_TRUE = "\033[92m";
public const string VAL_BOOL_FALSE = "\033[91m";
public const string VAL_NUMBER = "\033[94m";
public const string VAL_STRING = "\033[97m";

namespace Options {

	public void update_value (string key, string value) throws Error {
		string trash;
		var cmd = "vim -es -u ~/.vimrc -c 'call supraconfig#UpdateWithStringWithoutApply(";
		cmd += "\""+key+"\", \""+value+"\"";
		cmd += ")' -c 'q'";
		Process.spawn_command_line_sync (cmd, out trash, out trash);
	}

	public void reset_value (string key) throws Error {

		// get the default value for reset it:
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


	public void print_status () throws Error {
		var lst = SupraParser.get_from_vim();
		lst.sort ((a, b) => strcmp(a.id, b.id));

		string[] last_parts = {};

		foreach (var opt in lst) {
			if (opt == null) continue;

			string[] current_parts = opt.id.split("/");

			string path_acc = "";
			for (int i = 0; i < current_parts.length; i++) {
				string segment = current_parts[i];
				bool is_last = (i == current_parts.length - 1);
				path_acc = (path_acc == "") ? segment : path_acc + "/" + segment;

				if (is_last && !(path_acc in SupraParser.group_lores)) break;

				if (i >= last_parts.length || segment != last_parts[i]) {
					string group_lore = "";
					if (SupraParser.group_lores != null && path_acc in SupraParser.group_lores) {
						group_lore = SupraParser.group_lores[path_acc].lore;
					}

					string indent = string.nfill(i * 2, ' ');
					print (indent + GROUP_COLOR + "[" + segment + "]" + "   " + LORE_COLOR + group_lore + RESET + "\n");
				}
				if (is_last) break; 
			}

			string short_name = current_parts[current_parts.length - 1];
			int depth = current_parts.length - 1;
			if (opt.id in SupraParser.group_lores) depth++;

			string opt_indent = string.nfill(depth * 2 + 2, ' ');

			string v_color = VAL_STRING;
			if (opt.value == "true") v_color = VAL_BOOL_TRUE;
			else if (opt.value == "false") v_color = VAL_BOOL_FALSE;
			else if (opt.type == "number") v_color = VAL_NUMBER;

			int padding_size = 25 - short_name.length - (depth * 2);
			if (padding_size < 1) padding_size = 1;

			print (opt_indent + NAME_COLOR + short_name + RESET + ": " + 
					v_color + opt.value + RESET + "\033[31j" + LORE_COLOR + opt.lore + RESET + "\n");

			last_parts = current_parts;
		}
	}

	// for zsh and bash completion
	public void print_options() throws Error {
		var lst = SupraParser.get_from_vim();
		foreach (unowned var opt in lst) {
			if (opt == null)
				continue;
			print ("%s\n", opt.id);
		}
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
