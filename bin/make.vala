using Posix;

int	main(string []args)
{
	var path = Environment.get_variable ("PWD");
	var home = Environment.get_variable ("HOME");
	var i = path.length;
	var rules = args[1] ?? "all";

	i--;
	while (home != path && path != "/tmp" && i > 0)
	{
		if (access(path + "/Makefile", F_OK) == 0)
		{
			system(@"make -C $(path) $(rules) --no-print-directory");
			return (0);
		}
		else
		{
			while (path[i] != '/')
				i--;
			path.data[i] = '\0';
		}
	}
	return (-1);
}
