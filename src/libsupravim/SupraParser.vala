public struct SupravimOption {
	public string id;
	public string lore;
	public string value;
	public string type;
	public string default_value;

	public static SupravimOption empty() {
		return SupravimOption() {
			id = "", lore = "", value = "", type = "", default_value = ""
		};
	}
}

public struct SupravimGroup {
	public string id;
	public string lore;
}

public class SupraParser {
	public static HashTable<string, SupravimGroup?> group_lores;

	public static List<SupravimOption?> get_from_vim() throws Error {
		string output;
		string errput;
		string name_used;
		FileUtils.open_tmp("tmp_vim_redir_XXXXXXXX", out name_used);
		Process.spawn_command_line_sync(@"vim -es -u ~/.vimrc -c 'redir! > $name_used | call supraconfig#PrintRegister() | redir END' -c 'q'", out output, out errput);
		FileUtils.get_contents(name_used, out output);
		FileUtils.remove(name_used);
		return parse_full_package(output);
	}

	public static List<SupravimOption?> parse_full_package(string json) {
		group_lores = new HashTable<string, SupravimGroup?>(str_hash, str_equal);
		var options_list = new List<SupravimOption?>();

		string groups_content = get_raw_block(json, "groups");
		parse_groups_to_map(groups_content);

		string options_content = get_raw_block(json, "options");

		int i = 0;
		int depth = 0;
		int block_start = -1;
		bool in_quotes = false;

		while (i < options_content.length) {
			char c = options_content[i];
			if (c == '\\') { i += 2; continue; }
			if (c == '"') in_quotes = !in_quotes;

			if (!in_quotes) {
				if (c == '{') {
					depth++;
					if (depth == 1) block_start = i;
				} else if (c == '}') {
					depth--;
					if (depth == 0 && block_start != -1) {
						string block = options_content.substring(block_start, i - block_start + 1);
						options_list.append(parse_fields(block));
						block_start = -1;
					}
				}
			}
			i++;
		}
		return options_list;
	}

	private static string get_raw_block(string json, string key) {
		string search = @"\"$key\":";
		int pos = json.index_of(search);
		if (pos == -1) return "";

		int start = json.index_of_char('{', pos + search.length);
		int end = -1;
		int depth = 0;
		bool in_quotes = false;

		for (int i = start; i < json.length; i++) {
			char c = json[i];
			if (c == '\\') { i++; continue; }
			if (c == '"') in_quotes = !in_quotes;
			if (!in_quotes) {
				if (c == '{') depth++;
				else if (c == '}') {
					depth--;
					if (depth == 0) {
						end = i;
						break;
					}
				}
			}
		}
		return (start != -1 && end != -1) ? json.substring(start + 1, end - start - 1) : "";
	}

	private static void parse_groups_to_map(string content) {
		string[] pairs = content.split("\",\"");
		foreach (unowned var pair in pairs) {
			string[] kv = pair.split("\":\"");
			if (kv.length == 2) {
				string k = kv[0].replace("\"", "")._strip();
				string v = kv[1].replace("\"", "")._strip();
				SupravimGroup group = SupravimGroup() { id = k, lore = v };
				group_lores.insert(k, group); 
			}
		}
	}

	private static SupravimOption parse_fields(string block) {
		SupravimOption opt = SupravimOption();
		opt.id = get_json_value(block, "id");
		opt.lore = get_json_value(block, "lore");
		opt.value = get_json_value(block, "current");
		opt.type = get_json_value(block, "type");
		opt.default_value = get_json_value(block, "default");
		return opt;
	}

	private static string get_json_value(string block, string key) {
		string search = @"\"$key\":";
		int pos = block.index_of(search);
		if (pos == -1)
			return "";

		int start = pos + search.length;
		while (start < block.length && (block[start] == ' ' || block[start] == ':')) start++;

		if (start < block.length && block[start] == '"') {
			int end = block.index_of_char('"', start + 1);
			while (end != -1 && block[end-1] == '\\') end = block.index_of_char('"', end + 1);
			if (end == -1)
				return "";
			return block.substring(start + 1, end - start - 1);
		} else {
			int end = start;
			while (end < block.length && block[end] != ',' && block[end] != '}') end++;
			return block.substring(start, end - start)._strip();
		}
	}
}
