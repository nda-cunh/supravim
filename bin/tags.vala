// modules: posix;
using Posix;                                                                                                                                                                       

void search_dir(string dir_path, ref string tab_file)
{
	GLib.Dir dir;
	string name;

	try
	{
		dir = GLib.Dir.open (dir_path, 0);
		while ((name = dir.read_name ()) != null)
		{
			string path = Path.build_filename (dir_path, name);
			if (FileUtils.test (path, FileTest.IS_DIR)) {
				search_dir(path, ref tab_file);
				continue;
			}
			if(!(path.substring(-2, -1) == ".c") && !(path.substring(-5, -1) == ".vala") && !(path.substring(-4, -1) == ".cpp"))
				continue ;
			tab_file = @"$(tab_file)$(path) ";
		}
	}
	catch (FileError err)
	{
		printf (err.message);
	}
}

void create_tags(string super_path)
{
	string home = Environment.get_home_dir();
	string all_file = "";
	string []tablor = {"ctags"};

	tablor += @"-f$(home)/.local/bin/tags";
	search_dir(super_path, ref all_file);
	foreach(var n in all_file.split(" "))
	{
		if(n != "")
			tablor += n;
	}
	execvp("ctags", tablor);
}

void main(string []args)
{
	string path = Environment.get_current_dir();
	string home = Environment.get_home_dir();
	int i = path.length;

	i--;
	unlink(@"$home/.local/bin/tags");
	while (home != path && path != "/tmp" && i > 0)
	{
		if (access(path + "/Makefile", F_OK) == 0 || access(path + "/src", F_OK) == 0 || access(path + "/.git", F_OK) == 0)
			create_tags(path);
		else
		{
			while (path[i] != '/')
				i--;
			path.data[i] = '\0';
		}
	}
	create_tags(Environment.get_current_dir());
}
