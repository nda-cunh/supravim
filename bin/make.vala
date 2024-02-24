[CCode (cname="system", cheader_filename="stdlib.h")]
extern int system(string cmd);
[CCode (cname="strstr", cheader_filename="string.h")]
public extern unowned string strstr(string s1, string s2);

int   main(string []args) {
	int res = -1;
	try{
		res = supramake(args);
	}catch (Error e) {
		printerr(e.message);
	}
	return res;
}

int    supramake(string []args) throws Error{
	Process.signal(GLib.ProcessSignal.INT, sig_handler);
	string? path = Environment.get_variable ("PWD");
	string home = Environment.get_variable ("HOME");
	string []rules = {};
	string export_arg = "";

	var i = 1;
	while (args[i] != null) {
		if (args[i] == "--args" || args[i] == "--")
			break;
		rules += args[i];
		++i;
	}
	if (args[i] == "--args" || args[i] == "--")
		++i;
	while (args[i] != null){
		export_arg += @"\"$(args[i])\" ";
		++i;
	}
	Environment.set_variable("ARGS", export_arg, true);

	
	while (home != path && path != "/tmp" && path != null) {


		//		Makefile Build part 
		if (FileUtils.test(path + "/Makefile", FileTest.EXISTS)) {
			if (rules[0] == "valanocompileabcsupra")
				return (0);
			int wait_status;
			string av_exec = @"-C $path --no-print-directory ";
			foreach(var item in rules) {
				av_exec += @" $item ";
			}
			Process.spawn_command_line_sync(@"make $av_exec", null, null, out wait_status);
			return (wait_status);
		}

		//		Meson Build part 
		else if (FileUtils.test(path + "/meson.build", FileTest.EXISTS)) {
			var cmd = rules[0] ?? "";
			if (cmd.has_suffix("help"))
			{
				print("Help de meson:\n");
				return 0;
			}
			// search a true meson.build
			string ptr = path;
			string? before = ptr;
			while (true) {
				before = ptr;
				ptr = left_path(ptr);
				if (ptr == null)
					break;
				if (ptr.has_suffix("/subprojects")) {
					continue;
				}
				else if (FileUtils.test(ptr + "/meson.build", FileTest.EXISTS)) {
					continue;
				}
				break;
			}
			path = before;

			if (FileUtils.test(path + "/build", FileTest.IS_DIR | FileTest.EXISTS) == false) {
				print("Meson build detected !");
				Process.spawn_command_line_sync(@"meson setup $path/build $path/");
			}
			Process.spawn_command_line_sync(@"ninja -C $path/build");
			int wait_status;
			string all_av = Environment.get_variable("ARGS") ?? "";
			string name_exec = get_meson_exec(path);
			if (cmd != "" && cmd != "run") {
				name_exec = name_exec[0:name_exec.last_index_of_char('/')] + @"/$cmd";
				Process.spawn_command_line_sync(@"$cmd $all_av", null, null, out wait_status);
			}
			else {
				Process.spawn_command_line_sync(@"$name_exec $all_av", null, null, out wait_status);
			}
			return wait_status;
		}
		
		else {
			path = left_path(path);
		}
	}
	simple_exec();

	return (42);
}


string get_meson_exec (string path) throws Error{
	string contents;
	FileUtils.get_contents(@"$path/build/meson-info/intro-targets.json", out contents);

	var offset = contents.last_index_of("\"type\": \"executable\"");
	unowned string ptr = contents.offset(offset);
	var filename = strstr(ptr, "filename");
	var name = filename[13:filename.index_of_char('"', 13)];
	return name;
}

void exec(string ext){
	int status = -1;
	print("\033[31m[Supramake]\033[0m try to compile %s project without Makefile\n", ext);
	switch (ext) {
		case "vala":
			status = system("valac *.vala --pkg=posix -X -w -o a.out && ./a.out");
			break;
		case "c":
			status = system("clang -Wall -Wextra *.c -o a.out && ./a.out");
			break;
		case "cpp":
			status = system("clang++ -Wall -Wextra *.cpp -o a.out && ./a.out");
			break;
		case "sh":
			status = system("bash *.sh");
			break;
		case "py":
			status = system("python3 *.py");
			break;
	}
	Process.exit(status);
}

void simple_exec() throws Error {
	string path = Environment.get_variable ("PWD");
	string name;
	var dir = Dir.open(path, 0);
	while ((name = dir.read_name ()) != null) {
		if (name.has_suffix("vala"))
			exec(name.offset(name.last_index_of_char('.') + 1));
		else if (name.has_suffix("c"))
			exec(name.offset(name.last_index_of_char('.') + 1));
		else if (name.has_suffix("cpp"))
			exec(name.offset(name.last_index_of_char('.') + 1));
		else if (name.has_suffix("py"))
			exec(name.offset(name.last_index_of_char('.') + 1));
		else if (name.has_suffix("sh"))
			exec(name.offset(name.last_index_of_char('.') + 1));
	}
}

void    sig_handler (int sig)
{
	print("[SupraMake]: Send Ctrl+C to child\n");
}

string? left_path(string path) {
	if (path[path.length - 1] == '/') {
		path.data[path.length - 1] = ' ';
	}
	var offset = path.last_index_of_char('/');
	if (offset == -1)
		return null;
	var data = path.data;
	data[offset] = '\0';
	return (string)data;
}

