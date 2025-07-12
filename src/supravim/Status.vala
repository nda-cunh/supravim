private void print_list (ArrayElements lst) {
	foreach (unowned var elem in lst) { 
		stdout.printf ("%-20s\033[m ", elem.name);
		if (elem.type == BOOLEAN) {
			if (elem.value == "true")
				stdout.printf ("\033[92;1mon \033[m");
			else
				stdout.printf ("\033[91;1moff\033[m");
		}
		else if (elem.type == STRING) 
			stdout.printf ("\033[96;1m'%s'\033[m", elem.value);
		if (elem.comment != null)
			stdout.printf (" (%s)\n", elem.comment);
		else 
			stdout.printf ("\n");
	}
}

public void print_status () throws Error {

	unowned var lst_all = General.get ();
	// print ("Supravim Options:\n");

	var lst_general = lst_all.get_general ();
	var lst_plugins = lst_all.get_plugins ();


	stdout.printf ("\033[;1m-- GENERAL --\033[0m\n");
	print_list (lst_general);
	if (lst_plugins.size > 0) {
		stdout.printf ("\n\033[;1m-- PLUGINS --\033[0m\n");
		print_list (lst_plugins);
	}
}
