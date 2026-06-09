namespace Plugin {

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

	public bool add (string raw_url) throws Error {
		string url = resolve_url (raw_url);
		var plugins = new PluginsLst ();
		int wait;
		int idx     = url.last_index_of_char ('/');
		string name = url[idx + 1:];
		name._delimit (".", '\0');

		if (!plugins.add_from_url (url, name)) {
			printerr (BOLD + RED + "Plugin %s already exists\n" + DEFAULT, name);
			return false;
		}
		Process.spawn_command_line_sync (@"git clone --depth=1 $url $HOME/.vim/bundle/$name", null, null, out wait);
		if (wait != 0) {
			plugins.remove_from_name (name);
			printerr (BOLD + RED + "Failed to clone plugin %s\n" + DEFAULT, name);
			throw new SpawnError.FAILED ("git return %d", wait);
		}
		var entry = plugins.get_from_name (name);
		if (entry != null) {
			string commit = get_head_commit (name);
			if (commit != "")
				entry.installed_commit = commit;
		}
		return true;
	}

	public bool remove (string name) throws Error {
		var plugins = new PluginsLst ();
		if (!plugins.remove_from_name (name)) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		Process.spawn_command_line_sync (@"rm -rf $HOME/.vim/bundle/$name");
		print (BOLD + GREEN + "Plugin %s removed successfully\n" + DEFAULT, name);
		return true;
	}

	public bool disable (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		if (!entry.enabled) {
			printerr (BOLD + RED + "Plugin %s already disabled\n" + DEFAULT, name);
			return false;
		}
		entry.enabled = false;
		print (BOLD + GREEN + "Plugin %s disabled successfully\n" + DEFAULT, name);
		return true;
	}

	public bool enable (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		if (entry.enabled) {
			printerr (BOLD + RED + "Plugin %s already enabled\n" + DEFAULT, name);
			return false;
		}
		entry.enabled = true;
		print (BOLD + GREEN + "Plugin %s enabled successfully\n" + DEFAULT, name);
		return true;
	}

	public bool update_all () throws Error {
		var plugins = new PluginsLst ();
		for (int i = 0; i < (int) plugins.size; i++) {
			unowned var item = plugins.get (i);
			if (item.pinned != null) {
				stdout.printf (BOLD + "Skipping " + GREEN + "%s" + DEFAULT + BOLD + " (pinned at %s)\n" + DEFAULT, item.name, item.pinned);
				continue;
			}
			stdout.printf (BOLD + GREEN + "Updating plugin %s...\n" + DEFAULT, item.name);
			Process.spawn_command_line_sync (@"git -C $HOME/.vim/bundle/$(item.name) pull");
			string commit = get_head_commit (item.name);
			if (commit != "")
				item.installed_commit = commit;
			stdout.printf (BOLD + GREEN + "Plugin %s updated successfully\n" + DEFAULT, item.name);
		}
		return true;
	}

	public bool update (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		if (entry.pinned != null) {
			printerr (BOLD + RED + "Plugin %s is pinned at %s — use --unpin-plugin first\n" + DEFAULT, name, entry.pinned);
			return false;
		}
		Process.spawn_command_line_sync (@"git -C $HOME/.vim/bundle/$name pull");
		string commit = get_head_commit (name);
		if (commit != "")
			entry.installed_commit = commit;
		return true;
	}

	public bool pin (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		string commit = entry.installed_commit ?? get_head_commit (name);
		if (commit == "") {
			printerr (BOLD + RED + "Cannot get commit hash for %s\n" + DEFAULT, name);
			return false;
		}
		entry.pinned = commit;
		print (BOLD + GREEN + "Plugin %s pinned at %s\n" + DEFAULT, name, commit);
		return true;
	}

	public bool unpin (string name) throws Error {
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (name);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, name);
			return false;
		}
		if (entry.pinned == null) {
			printerr (BOLD + RED + "Plugin %s is not pinned\n" + DEFAULT, name);
			return false;
		}
		entry.pinned = null;
		print (BOLD + GREEN + "Plugin %s unpinned\n" + DEFAULT, name);
		return true;
	}

	public bool add_group (string arg) throws Error {
		var parts = arg.split (":", 2);
		if (parts.length != 2) {
			printerr (BOLD + RED + "Expected format: <plugin>:<group>\n" + DEFAULT);
			return false;
		}
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (parts[0]);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, parts[0]);
			return false;
		}
		string group = parts[1].strip ();
		if (entry.groups == null || entry.groups == "")
			entry.groups = group;
		else if (!(group in entry.groups.split (",")))
			entry.groups += "," + group;
		print (BOLD + GREEN + "Plugin %s added to group '%s'\n" + DEFAULT, parts[0], group);
		return true;
	}

	public bool remove_group (string arg) throws Error {
		var parts = arg.split (":", 2);
		if (parts.length != 2) {
			printerr (BOLD + RED + "Expected format: <plugin>:<group>\n" + DEFAULT);
			return false;
		}
		var plugins = new PluginsLst ();
		var entry = plugins.get_from_name (parts[0]);
		if (entry == null) {
			printerr (BOLD + RED + "Plugin %s not found\n" + DEFAULT, parts[0]);
			return false;
		}
		string group = parts[1].strip ();
		if (entry.groups == null) return true;
		string[] remaining = {};
		foreach (string g in entry.groups.split (","))
			if (g.strip () != group)
				remaining += g;
		entry.groups = remaining.length > 0 ? string.joinv (",", remaining) : null;
		print (BOLD + GREEN + "Plugin %s removed from group '%s'\n" + DEFAULT, parts[0], group);
		return true;
	}

	public bool enable_group (string group) throws Error {
		var plugins = new PluginsLst ();
		int count = 0;
		for (int i = 0; i < (int) plugins.size; i++) {
			unowned var item = plugins.get (i);
			if (item.groups != null && group in item.groups.split (",")) {
				item.enabled = true;
				count++;
			}
		}
		if (count == 0) {
			printerr (BOLD + RED + "No plugins found in group '%s'\n" + DEFAULT, group);
			return false;
		}
		print (BOLD + GREEN + "%d plugin(s) in group '%s' enabled\n" + DEFAULT, count, group);
		return true;
	}

	public bool disable_group (string group) throws Error {
		var plugins = new PluginsLst ();
		int count = 0;
		for (int i = 0; i < (int) plugins.size; i++) {
			unowned var item = plugins.get (i);
			if (item.groups != null && group in item.groups.split (",")) {
				item.enabled = false;
				count++;
			}
		}
		if (count == 0) {
			printerr (BOLD + RED + "No plugins found in group '%s'\n" + DEFAULT, group);
			return false;
		}
		print (BOLD + GREEN + "%d plugin(s) in group '%s' disabled\n" + DEFAULT, count, group);
		return true;
	}

	public bool list (string? group_filter = null, bool only_pinned = false, bool only_disabled = false) throws Error {
		var plugins = new PluginsLst ();
		if (plugins.size == 0) {
			printerr (BOLD + RED + "No plugins found\n" + DEFAULT);
			return false;
		}
		bool any = false;
		for (int i = 0; i < (int) plugins.size; i++) {
			unowned var item = plugins.get (i);

			if (only_pinned   && item.pinned == null)  continue;
			if (only_disabled && item.enabled)          continue;
			if (group_filter  != null) {
				if (item.groups == null || !(group_filter in item.groups.split (",")))
					continue;
			}

			string status = item.enabled ? GREEN + "Enable" : RED + "Disable";
			string extra  = "";
			if (item.pinned != null)
				extra += " [pinned: " + item.pinned + "]";
			if (item.groups != null && item.groups != "")
				extra += " [groups: " + item.groups + "]";
			print (BOLD + "%-15s " + status + DEFAULT + extra + "\n", item.name);
			any = true;
		}
		if (!any)
			printerr (BOLD + RED + "No plugins match the given filters\n" + DEFAULT);
		return any;
	}

	public bool print_all_installed_plugins () throws Error {
		var plugins = new PluginsLst ();
		for (int i = 0; i < (int) plugins.size; i++)
			print ("%s\n", plugins.get (i).name);
		return true;
	}

	public bool print_all_groups () throws Error {
		var plugins = new PluginsLst ();
		var seen = new HashTable<string, bool> (str_hash, str_equal);
		for (int i = 0; i < (int) plugins.size; i++) {
			unowned var item = plugins.get (i);
			if (item.groups == null) continue;
			foreach (string g in item.groups.split (",")) {
				if (!seen.contains (g)) {
					seen[g] = true;
					print ("%s\n", g);
				}
			}
		}
		return true;
	}
}
