using Gee;

private void print_list (Gee.ArrayList<Gee.Map.Entry<weak string, Element>> lst) {
	foreach (var entry in lst) { 
		unowned var elem = entry.value;
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

int get_score (Map.Entry<unowned string, Element> entry) {
	if (entry.value.value == "true")
		return 1;
	else if (entry.value.value == "false")
		return 0;
	else
		return -1; 
}

public void print_status () throws Error {

	var lst_all = General.get ();
	print ("Supravim Options:\n");

	var lst_general = new ArrayList<Map.Entry<unowned string, Element>> ();
	var lst_plugins = new ArrayList<Map.Entry<unowned string, Element>> ();

	lst_general.add_all_iterator(lst_all.filter((a) => (a.value.file == rc_path)).order_by ((a, b) => get_score (b) - get_score (a)));
	lst_plugins.add_all_iterator(lst_all.filter((a) => (a.value.file != rc_path)).order_by ((a, b) => get_score (b) - get_score (a)));

	print ("\033[;1m -- GENERAL --\033[0m\n");
	print_list (lst_general);
	if (lst_plugins.size > 0) {
		print ("\n\033[;1m -- PLUGINS --\033[0m\n");
		print_list (lst_plugins);
	}
}
