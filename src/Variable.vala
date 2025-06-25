
public void change_variables(string []elements) {
	foreach (unowned var elem in elements) {
		if (!("=" in elem)) {
			print("Option \033[93;1m%s\033[m must have a value.\n", elem);
			continue;
		}
		var name = elem.split("=");

	}
}
