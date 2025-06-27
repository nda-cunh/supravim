public errordomain ErrorOption {
	OPTION_NOT_FOUND,
	INCOMPATIBLE_OPTION_TYPE,
	VALUE_NOT_GIVEN
}

namespace Modificator {
	// ------------ UPDATE BOOLEAN OPTION ------------ //

	public void	enable (string var_name) throws Error {
		var elem = check_option_validity(var_name, "true");
		Modificator.update_value(elem, "true");
		print("%s: \033[1;92menabled\033[m\n", var_name);
	}

	public void	disable (string var_name) throws Error {
		var elem = check_option_validity(var_name, "true");
		Modificator.update_value(elem, "false");
		print("%s: \033[1;91mdisabled\033[m\n", var_name);
	}

	// ------------ UPDATE BOOLEAN OPTION ------------ //

	public void	set_value (string str) throws Error {
		if (("=" in str) == false)
			throw new ErrorOption.VALUE_NOT_GIVEN("%s: Any value given.", str);

		var index_of_equal = str.index_of_char('=');
		str.data[index_of_equal] = '\0'; 
		unowned var var_name = str;
		unowned var new_value = str.offset(index_of_equal + 1);

		var elem = check_option_validity (var_name, new_value);
		Modificator.update_value(elem, new_value);
		print("%s set to \033[1;96m%s\033[m\n", var_name, new_value);
	}

	// ------------ FACTORIZED FUNCTIONS ------------ //

	private Element check_option_validity (string var_name, string new_val) throws Error {
		var option_sp = General.get();

		if ((option_sp.has_key (new_val)) == false)
			throw new ErrorOption.OPTION_NOT_FOUND("%s: option not found.", var_name);

		var type = option_sp[var_name].type;
		var is_number = /^[0-9]+([.][0-9]+)?$/.match(new_val);
		var is_bool  = (new_val == "true" || new_val == "false");
		if (is_bool != (type == OptionType.BOOLEAN))
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE("%s: incompatible type (boolean expected)", var_name);
		else if (is_number != (type == OptionType.NUMBER))
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE("%s: incompatible type (number expected)", var_name);
		return option_sp[var_name];
	}

	private void update_value (Element elem, string new_value) throws Error {
		if (new_value == elem.value) {
			print("No need to update, value is the same.\n");
			return; // No need to update if the value is the same
		}
		// Regex to match the option line
		var opt_regex = new Regex(@"^g:sp_$(elem.name).+?\n", RegexCompileFlags.DOTALL|RegexCompileFlags.MULTILINE);

		// Construct new line with the value
		string replacement;
		if (elem.type == STRING) {
			if (elem.comment != null)
				replacement = @"g:sp_$(elem.name) = '$new_value'\t# $(elem.comment)\n";
			else
				replacement = @"g:sp_$(elem.name) = '$new_value'\n";
		}
		else {
			if (elem.comment != null)
				replacement = @"g:sp_$(elem.name) = $new_value\t# $(elem.comment)\n";
			else
				replacement = @"g:sp_$(elem.name) = $new_value\n";
		}
		// Get file content
		string contents;
		FileUtils.get_contents (elem.file, out contents);

		// Replace contents with new value
		contents = opt_regex.replace(contents, -1, 0, replacement, 0);
		FileUtils.set_contents(elem.file, contents);
	}
}
