namespace Supravim.Cfg {

	/**
	  * Get Configuration directory
	  */
	private string config_dir () {
		return Environment.get_user_config_dir () + "/supravim";
	}

	/**
	  * Get YOUR CONFIG content from ~/.vimrc
	  */
	private string extract_your_config () {
		try {
			string contents;
			FileUtils.get_contents (rc_path, out contents);
			var regex = new Regex (
				"""^[#][=]{5,60}[ ]*\bYOUR CONFIG\b[ ]*[=]{5,60}\n(.*)""",
				RegexCompileFlags.MULTILINE | RegexCompileFlags.DOTALL
			);
			MatchInfo info;
			if (regex.match (contents, 0, out info))
				return info.fetch (1);
		} catch (Error e) {}
		return "";
	}

	/**
	  * Restore YOUR CONFIG content to ~/.vimrc
	  */
	private void restore_your_config (string your_config) throws Error {
		string vimrc;
		FileUtils.get_contents (rc_path, out vimrc);
		var sb = new StringBuilder (vimrc);
		var idx = sb.str.last_index_of ("#====================== YOUR CONFIG =======================");
		if (idx != -1)
			sb.len = idx;
		sb.append ("#====================== YOUR CONFIG =======================\n");
		if (your_config.strip () != "") {
			sb.append (your_config);
			if (!your_config.has_suffix ("\n"))
				sb.append_c ('\n');
		}
		FileUtils.set_contents (rc_path, sb.str);
	}

	/**
	  * Reclone all plugins from ~/.vim/bundle
	  */
	private void reclone_plugins () throws Error {
		var plugins = new Plugin.PluginsLst ();
		string bundle = @"$(HOME)/.vim/bundle";
		DirUtils.create_with_parents (bundle, 0755);
		for (int i = 0; i < (int) plugins.size; i++) {
			var p = plugins.get (i);
			string dest = Path.build_filename (bundle, p.name);
			if (FileUtils.test (dest, FileTest.IS_DIR))
				continue;
			int wait;
			if (p.pinned != null) {
				Process.spawn_command_line_sync ("git clone '%s' '%s'".printf (p.url, dest), null, null, out wait);
				if (wait == 0)
					Process.spawn_command_line_sync ("git -C '%s' checkout %s".printf (dest, p.pinned));
			} else {
				Process.spawn_command_line_sync ("git clone --depth=1 '%s' '%s'".printf (p.url, dest), null, null, out wait);
			}
			if (wait != 0)
				warning ("Failed to clone plugin %s", p.name);
		}
	}

	/**
	  * Copy recursively a file or directory to another location.
	  */
	private void copy_recursive (File src, File dest) throws Error {
		var type = src.query_file_type (FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
		if (type == FileType.DIRECTORY) {
			dest.make_directory_with_parents ();
			var en = src.enumerate_children ("standard::name", FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
			FileInfo info;
			while ((info = en.next_file ()) != null)
				copy_recursive (src.get_child (info.get_name ()), dest.get_child (info.get_name ()));
		} else {
			src.copy (dest, FileCopyFlags.OVERWRITE);
		}
	}

	/**
	  * Remove recursively a file or directory.
	  */
	private void remove_recursive (File f) {
		try {
			var type = f.query_file_type (FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
			if (type == FileType.DIRECTORY) {
				var en = f.enumerate_children ("standard::name", FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
				FileInfo info;
				while ((info = en.next_file ()) != null)
					remove_recursive (f.get_child (info.get_name ()));
			}
			f.delete ();
		} catch (Error e) {}
	}

	/**
	  * Export the current SupraVim configuration to a .supravim archive.
	  * The archive contains the ~/.config/supravim directory (without last_version.txt)
	  * and the YOUR CONFIG block from ~/.vimrc in a yourconfig.vim file.
	  *
	  * @param out_path path of the output .supravim file.
	 */
	public void export_config (string out_path) throws Error {
		string path = out_path;
		if (!path.has_suffix (".supravim"))
			path += ".supravim";

		string tmp = DirUtils.make_tmp ("supravim-export-XXXXXX");
		try {
			string stage = Path.build_filename (tmp, "supravim");
			DirUtils.create_with_parents (stage, 0755);

			var dir = Dir.open (config_dir ());
			string? name;
			while ((name = dir.read_name ()) != null) {
				if (name == "last_version.txt")
					continue;
				copy_recursive (
					File.new_for_path (Path.build_filename (config_dir (), name)),
					File.new_for_path (Path.build_filename (stage, name))
				);
			}

			FileUtils.set_contents (
				Path.build_filename (stage, "yourconfig.vim"),
				extract_your_config ()
			);

			int wait;
			Process.spawn_command_line_sync (
				"tar czf '%s' -C '%s' supravim".printf (path, tmp), null, null, out wait
			);
			if (wait != 0)
				throw new SupravimError.UNKNOWN_ERROR ("tar failed while creating %s".printf (path));
		} finally {
			remove_recursive (File.new_for_path (tmp));
		}
	}

	/**
	 * Import a SupraVim configuration from a .supravim archive.
	 *
	 * @param in_path path of the input .supravim file. 
	 */
	public void import_config (string in_path) throws Error {
		if (!FileUtils.test (in_path, FileTest.EXISTS))
			throw new SupravimError.NOT_FOUND ("File %s not found".printf (in_path));

		string tmp = DirUtils.make_tmp ("supravim-import-XXXXXX");
		try {
			int wait;
			Process.spawn_command_line_sync (
				"tar xzf '%s' -C '%s'".printf (in_path, tmp), null, null, out wait
			);
			if (wait != 0)
				throw new SupravimError.UNKNOWN_ERROR ("tar failed while extracting %s".printf (in_path));

			string stage = Path.build_filename (tmp, "supravim");
			if (!FileUtils.test (stage, FileTest.IS_DIR))
				throw new SupravimError.BAD_VALUE ("%s is not a valid SupraVim config archive".printf (in_path));

			string your_config_file = Path.build_filename (stage, "yourconfig.vim");
			if (FileUtils.test (your_config_file, FileTest.EXISTS)) {
				string your_config;
				FileUtils.get_contents (your_config_file, out your_config);
				restore_your_config (your_config);
				FileUtils.remove (your_config_file);
			}

			string cfg = config_dir ();
			string? last_version = null;
			string lv_path = Path.build_filename (cfg, "last_version.txt");
			if (FileUtils.test (lv_path, FileTest.EXISTS))
				FileUtils.get_contents (lv_path, out last_version);

			remove_recursive (File.new_for_path (cfg));
			copy_recursive (File.new_for_path (stage), File.new_for_path (cfg));

			if (last_version != null)
				FileUtils.set_contents (Path.build_filename (cfg, "last_version.txt"), last_version);

			reclone_plugins ();
		} finally {
			remove_recursive (File.new_for_path (tmp));
		}
	}
}
