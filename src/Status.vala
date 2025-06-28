private void print_list (ArrayElements lst) {
	foreach (unowned var elem in lst) { 
		print ("%-20s\033[m ", elem.name);
		if (elem.type == BOOLEAN) {
			if (elem.value == "true")
				print ("\033[92;1mon \033[m");
			else
				print ("\033[91;1moff\033[m");
		}
		else if (elem.type == STRING)
			print ("\033[96;1m%s\033[m\n", elem.value);
		if (elem.comment != null)
			print (" (%s)\n", elem.comment);
	}
}

public void print_status () throws Error {

	var lst_all = General.get ();
	print ("Supravim Options:\n");

	var lst_general = lst_all.get_general ();
	var lst_plugins = lst_all.get_plugins ();


	print ("\033[;1m -- GENERAL --\033[0m\n");
	print_list (lst_general);
	if (lst_plugins.size > 0) {
		print ("\n\033[;1m -- PLUGINS --\033[0m\n");
		print_list (lst_plugins);
	}
}
