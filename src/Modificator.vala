public errordomain ErrorOption {
	OPTION_NOT_FOUND,
	INCOMPATIBLE_OPTION_TYPE,
	VALUE_NOT_GIVEN
}

namespace Modificator {
	// ------------ UPDATE BOOLEAN OPTION ------------ //

	public void	enable(string var_name) throws Error {
		unowned var elem = check_option_validity(var_name, "true");
		Modificator.update_value(elem, "true");
		print(@"$var_name: \033[1;92menabled\033[m\n");
	}

	public void	disable(string var_name) throws Error {
		unowned var elem = check_option_validity(var_name, "true");
		Modificator.update_value(elem, "false");
		print(@"$var_name: \033[1;91mdisabled\033[m\n");
	}

	// ------------ UPDATE BOOLEAN OPTION ------------ //

	public void	set_value(string str) throws Error {
		if (!str.contains("="))
			throw new ErrorOption.VALUE_NOT_GIVEN(@"$str: Any value given.");

		var str_arr = str.split("=", 2);
		unowned var var_name = str_arr[0];
		var new_value = str_arr[1];

		unowned var elem = check_option_validity(var_name, new_value);
		if (elem.type == OptionType.STRING)
			new_value = @"'$new_value'";
		Modificator.update_value(elem, new_value);
		print(@"$var_name set to \033[1;96m$new_value\033[m\n");
	}

	// ------------ FACTORIZED FUNCTIONS ------------ //

	private unowned Element check_option_validity(string var_name, string new_val) throws Error {
		var option_sp = General.get();

		if (!option_sp.contains(var_name))
			throw new ErrorOption.OPTION_NOT_FOUND(@"$var_name: option not found.");

		unowned var type = option_sp[var_name].type;
		var is_number = /^[0-9]+([.][0-9]+)?$/.match(new_val);
		var is_bool  = (new_val == "true" || new_val == "false");

		if (is_bool != (type == OptionType.BOOLEAN))
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE(@"$var_name: incompatible type");
		else if (is_number != (type == OptionType.NUMBER))
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE(@"$var_name: incompatible type");
		return option_sp[var_name];
	}

	private void	update_value(Element elem, string new_value) throws Error {
		// Regex to match the option line
		var opt_regex = new Regex(@"^g:sp_$(elem.name).+?\n", RegexCompileFlags.DOTALL|RegexCompileFlags.MULTILINE);

		// Construct new line with the value
		var replacement = @"g:sp_$(elem.name) = $new_value\n";
		if (elem.comment != null)
			replacement = @"g:sp_$(elem.name) = $new_value\t# $(elem.comment)\n";

		// Get file content
		string contents;
		FileUtils.get_contents (elem.file, out contents);

		// Replace contents with new value
		contents = opt_regex.replace(contents, -1, 0, replacement, 0);
		FileUtils.set_contents(elem.file, contents);	
	}
}
