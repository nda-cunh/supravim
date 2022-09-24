// modules: posix

using Posix;

int	main(string []args)
{
	string path = Environment.get_variable ("PWD");
	string home = Environment.get_variable ("HOME");
	string rules = args[1] ?? "all";
	int i = path.length - 1;
	int ret;

	while (home != path && path != "/tmp" && i > 0)
	{
		if (access(path + "/Makefile", F_OK) == 0)
		{
			int pid = fork();
			if (pid == 0)
			{
				execvp("make", {"make", "-C", path, rules, "--no-print-directory"});
			}
			waitpid(pid, out ret, 0);
			return (ret);
		}
		else
		{
			while (path[i] != '/')
				i--;
			path.data[i] = '\0';
		}
	}
	return (42);
}
