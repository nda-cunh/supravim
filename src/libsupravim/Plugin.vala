namespace Supravim.Plugin {

	private string resolve_url (string input) {
		if (input.contains ("://") || input.has_prefix ("/"))
			return input;
		if (input.contains ("/"))
			return "https://github.com/" + input;
		return input;
	}

	private string get_head_commit (string name) {
		string out_str = "";
		try {
			Process.spawn_command_line_sync (
				@"git -C $HOME/.vim/bundle/$name rev-parse --short HEAD",
				out out_str
			);
		} catch (Error e) {}
		return out_str._strip ();
	}

	public void add (string raw_url) throws Error {
		string url = resolve_url (raw_url);
		var plugins = new PluginsLst ();
		int wait;
		int idx     = url.last_index_of_char ('/');
		string name = url[idx + 1:];
		name._delimit (".", '\0');

		if (!plugins.add_from_url (url, name))
			throw new SupravimError.ALREADY_EXISTS ("Plugin %s already exists".printf (name));
		Process.spawn_command_line_sync (@"git clone --depth=1 $url $HOME/.vim/bundle/$name", null, null, out wait);
		if (wait != 0) {
			plugins.remove_from_name (name);
			throw new SpawnError.FAILED ("git clone returned %d for %s".printf (wait, name));
		}
		var entry = plugins.get_from_name (name);
		if (entry != null) {
			string commit = get_head_commit (name);
			if (commit != "")
				entry.installed_commit = commit;
		}
	}

	public void remove (string name) throws Error {
		var plugins = new PluginsLst ();
		if (!plugins.remove_from_name (name))
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (name));
		Process.spawn_command_line_sync (@"rm -rf $HOME/.vim/bundle/$name");
	}

	public void disable (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (name));
		if (!entry.enabled)
			throw new SupravimError.BAD_VALUE ("Plugin %s is already disabled".printf (name));
		entry.enabled = false;
	}

	public void enable (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (name));
		if (entry.enabled)
			throw new SupravimError.BAD_VALUE ("Plugin %s is already enabled".printf (name));
		entry.enabled = true;
	}

	public void update_all () throws Error {
		var plugins = new PluginsLst ();
		for (int i = 0; i < (int) plugins.size; i++) {
			var item = plugins.get (i);
			if (item.pinned != null)
				continue;
			Process.spawn_command_line_sync (@"git -C $HOME/.vim/bundle/$(item.name) pull");
			string commit = get_head_commit (item.name);
			if (commit != "")
				item.installed_commit = commit;
		}
	}

	public void update (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (name));
		if (entry.pinned != null)
			throw new SupravimError.BAD_VALUE ("Plugin %s is pinned at %s — use --unpin-plugin first".printf (name, entry.pinned));
		Process.spawn_command_line_sync (@"git -C $HOME/.vim/bundle/$name pull");
		string commit = get_head_commit (name);
		if (commit != "")
			entry.installed_commit = commit;
	}

	// Returns the commit hash the plugin was pinned at.
	public string pin (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (name));
		string commit = entry.installed_commit ?? get_head_commit (name);
		if (commit == "")
			throw new SupravimError.UNKNOWN_ERROR ("Cannot get commit hash for %s".printf (name));
		entry.pinned = commit;
		return commit;
	}

	public void unpin (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (name));
		if (entry.pinned == null)
			throw new SupravimError.BAD_VALUE ("Plugin %s is not pinned".printf (name));
		entry.pinned = null;
	}

	public void add_group (string plugin, string group) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (plugin);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (plugin));
		if (entry.groups == null || entry.groups == "")
			entry.groups = group;
		else if (!(group in entry.groups.split (",")))
			entry.groups += "," + group;
	}

	public void remove_group (string plugin, string group) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (plugin);
		if (entry == null)
			throw new SupravimError.NOT_FOUND ("Plugin %s not found".printf (plugin));
		if (entry.groups == null) return;
		string[] remaining = {};
		foreach (string g in entry.groups.split (","))
			if (g.strip () != group)
				remaining += g;
		entry.groups = remaining.length > 0 ? string.joinv (",", remaining) : null;
	}

	// Returns the number of plugins affected.
	public int enable_group (string group) throws Error {
		var plugins = new PluginsLst ();
		int count = 0;
		for (int i = 0; i < (int) plugins.size; i++) {
			var item = plugins.get (i);
			if (item.groups != null && group in item.groups.split (",")) {
				item.enabled = true;
				count++;
			}
		}
		if (count == 0)
			throw new SupravimError.NOT_FOUND ("No plugins found in group '%s'".printf (group));
		return count;
	}

	// Returns the number of plugins affected.
	public int disable_group (string group) throws Error {
		var plugins = new PluginsLst ();
		int count = 0;
		for (int i = 0; i < (int) plugins.size; i++) {
			var item = plugins.get (i);
			if (item.groups != null && group in item.groups.split (",")) {
				item.enabled = false;
				count++;
			}
		}
		if (count == 0)
			throw new SupravimError.NOT_FOUND ("No plugins found in group '%s'".printf (group));
		return count;
	}

	public List<PluginEntry> get_all () throws Error {
		var lst = new PluginsLst ();
		var result = new List<PluginEntry> ();
		for (int i = 0; i < (int) lst.size; i++)
			result.append (lst.get (i));
		return result;
	}

	public List<string> get_all_groups () throws Error {
		var lst = new PluginsLst ();
		var seen = new HashTable<string, bool> (str_hash, str_equal);
		var result = new List<string> ();
		for (int i = 0; i < (int) lst.size; i++) {
			var item = lst.get (i);
			if (item.groups == null) continue;
			foreach (string g in item.groups.split (",")) {
				if (!seen.contains (g)) {
					seen[g] = true;
					result.append (g);
				}
			}
		}
		return result;
	}
}
