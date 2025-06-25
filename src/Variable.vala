
public void change_variables(string []elements) {
	foreach (unowned var elem in elements) {
		if (!("=" in elem)) {
			print("Option \033[93;1m%s\033[m must have a value.\n", elem);
			continue;
		}
		var name = elem.split("=");

	}
}
 // for elem in elements:
        // if '=' not in elem:
            // print(f"Option \033[93;1m{elem}\033[m must have a value.")
            // continue
// 
        // name, new_value = elem.split('=')
// 
        // if name not in sv_options:
            // print(f"Option \033[93;1m{name}\033[m not found.")
            // continue
// 
        // filename, value = sv_options[name][0], sv_options[name][1]
// 
        // # Read the file
        // with open(filename, 'r') as file:
            // data = file.read()
// 
        // value = value.replace('\n', '')
// 
        // reg = re.compile(f'\ng:sp_{name} = (?:\'.*?\'|".*?")')
// 
        // matches = reg.findall(data)
// 
        // if not matches:
            // print(f"Option \033[93;1m{name}\033[m value isn't a string.")
            // continue
// 
        // data = re.sub(reg, f'\ng:sp_{name} = \'{new_value}\'', data)
