private void print_list (ArrayElements lst, int size_max) {
	foreach (unowned var elem in lst) { 
		stdout.printf ("%-20s\033[m ", elem.name);
		if (elem.type == BOOLEAN) {
			if (elem.value == "true")
				stdout.printf ("\033[92;1mon%*s\033[m", size_max - 2, " ");
			else
				stdout.printf ("\033[91;1moff%*s\033[m", size_max - 3, " ");
		}
		else if (elem.type == STRING) 
			stdout.printf ("\033[96;1m'%s'%*s\033[m", elem.value, size_max - elem.value.char_count () - 2, " ");
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

	int size_max = 1;
	foreach (unowned var elem in lst_general) {
		if (elem.value.length > size_max)
			size_max = elem.value.length;
	}
	foreach (unowned var elem in lst_plugins) {
		if (elem.value.length > size_max)
			size_max = elem.value.length;
	}

	size_max += 3; // for quotes
	stdout.printf ("\033[;1m-- GENERAL --\033[0m\n");
	print_list (lst_general, size_max);
	if (lst_plugins.size > 0) {
		stdout.printf ("\n\033[;1m-- PLUGINS --\033[0m\n");
		print_list (lst_plugins, size_max);
	}
}
