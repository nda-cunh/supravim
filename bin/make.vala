using Posix;
public int pid;

int    main(string []args) {
	signal(SIGINT, sig_handler);
	string path = Environment.get_variable ("PWD");
	string home = Environment.get_variable ("HOME");
	string []rules = {};
	string export_arg = "";
	string []av_exec;

	if (args[1] == null){
		rules += "all";
	}
	else{
		var i = 1;
		while (args[i] != null) {
			if (args[i] == "--arg")
				break;
			rules += args[i];
			i++;
		}
		if (args[i] == "--arg")
			i++;
		while (args[i] != null){
			export_arg += @"\"$(args[i])\" ";
			i++;
		}
		Environment.set_variable("ARG", export_arg, true);
	}
	int i = path.length - 1;
	int ret;

	while (home != path && path != "/tmp" && i > 0) {
		if (access(path + "/Makefile", F_OK) == 0) {
			pid = fork();
			if (pid == 0)
			{
				if (rules[0] == "valanocompileabcsupra")
					return (0);
				av_exec = {"make", "-C", path, "--no-print-directory"};
				foreach(var item in rules){
					av_exec += item;
				}
				execvp("make", av_exec);
			}
			waitpid(pid, out ret, 0);
			return (ret);
		}
		else {
			while (path[i] != '/')
				i--;
			path.data[i] = '\0';
		}
	}
	return (42);
}

void    sig_handler (int sig)
{
	if (sig == SIGINT){
		print("[SupraMake]: Send Ctrl+C to %d", pid);
		kill(pid, SIGINT);
	}
}