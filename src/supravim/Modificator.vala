public errordomain ErrorOption {
	OPTION_NOT_FOUND,
	INCOMPATIBLE_OPTION_TYPE,
	VALUE_NOT_GIVEN
}

namespace Modificator {
	/**
	 * Enable a boolean option.
	 * @param var_name The name of the option to enable.
	 * @throws Error If the option is not found or if the type is incompatible.
	 */
	public void	enable (string var_name) throws Error {
		var elem = check_option_validity(var_name, "true");
		Modificator.update_value_from_elem(elem, "true");
		print("%s: \033[1;92menabled\033[m\n", var_name);
	}

	/**
	 * Disable a boolean option.
	 * @param var_name The name of the option to disable.
	 * @throws Error If the option is not found or if the type is incompatible.
	 */
	public void	disable (string var_name) throws Error {
		var elem = check_option_validity(var_name, "true");
		Modificator.update_value_from_elem(elem, "false");
		print("%s: \033[1;91mdisabled\033[m\n", var_name);
	}


	/**
	 * Set a variable to a new value.
	 * The string should be in the format "name=value".
	 * @param str The string containing the variable name and value.
	 * @throws Error If the value is not given or if the option is not found.
	 */
	public void	set_value (string str) throws Error {
		if (("=" in str) == false)
			throw new ErrorOption.VALUE_NOT_GIVEN("%s: Any value given.", str);

		var index_of_equal = str.index_of_char('=');
		str.data[index_of_equal] = '\0'; 
		unowned var var_name = str;
		unowned var new_value = str.offset(index_of_equal + 1);

		set_variable(var_name, new_value);
	}
	
	/**
	 * Set a variable to a new value.
	 * @param name The name of the variable to set.
	 * @param value The new value for the variable.
	 * @throws Error If the option is not found or if the type is incompatible.
	 */
	public void	set_variable (string name, string value) throws Error {
		var elem = check_option_validity (name, value);
		Modificator.update_value_from_elem(elem, value);
		print("%s set to \033[1;96m%s\033[m\n", name, value);
	}

	/**
	 * Check if the option is valid and return the corresponding Element.
	 * @param var_name The name of the option to check.
	 * @param new_val The new value to check against the option type.
	 * @return The Element corresponding to the option.
	 * @throws Error If the option is not found or if the type is incompatible.
	 */
	private unowned Element check_option_validity (string var_name, string new_val) throws Error {
		var option_sp = General.get();

		unowned var elem = option_sp.find(var_name);
		if (elem == null)
			throw new ErrorOption.OPTION_NOT_FOUND("%s: option not found.", var_name);

		var type = elem.type;
		var is_number = /^[0-9]+([.][0-9]+)?$/.match(new_val);
		var is_bool  = (new_val == "true" || new_val == "false");
		if (is_bool != (type == OptionType.BOOLEAN))
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE("%s: incompatible type (boolean expected)", var_name);
		else if (is_number != (type == OptionType.NUMBER))
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE("%s: incompatible type (number expected)", var_name);
		return elem;
	}

	/**
	 * Update the value of an option from an Element.
	 * @param elem The Element containing the option details.
	 * @param new_value The new value to set for the option.
	 * @throws Error If the value is the same as the current value.
	 */
	private void update_value_from_elem (Element elem, string new_value) throws Error {
		if (new_value == elem.value)
			return; // No need to update if the value is the same
		update_value(elem.name, new_value, elem.file, elem.type, elem.comment);
	}
	
	/**
	 * Update the value of an option in the specified file.
	 * @param name The name of the option to update.
	 * @param new_value The new value to set for the option.
	 * @param filename The file where the option is defined.
	 * @param type The type of the option (STRING, NUMBER, BOOLEAN).
	 * @param comment An optional comment to add to the option line.
	 * @throws Error If the option line cannot be found or if the file cannot be read.
	 */
	public void update_value (string name, string new_value, string filename, OptionType type, string? comment) throws Error {
		string contents;
		FileUtils.get_contents (filename, out contents);
		var sb = new StringBuilder(contents);
		update_value_with_contents(name, new_value, type, comment, sb);
		FileUtils.set_contents(filename, sb.str);
	}

	public void update_value_with_contents (string name, string new_value, OptionType type, string? comment, StringBuilder sb) {
		// PERF only for optimization use stack instead heap
		uint8 buffer[128];
		Utils.sprintf (buffer, "\ng:sp_%s = ", name);
		unowned string str_find = (string) buffer;
	
		// Find the line that starts with "g:sp_name = "
		var idx = sb.str.index_of (str_find);

		if (idx == -1) {
			warning ("%s: option line not found [%s]", name, str_find);
			return ;
		}
		++idx;
		// unowned string ptr = contents.offset(idx);
		var idx_end = sb.str.index_of_char('\n', idx);

		sb.erase (idx, idx_end - idx + 1);
		if (type == STRING) {
			if (comment != null)
				Utils.sprintf (buffer, "\ng:sp_%s = \"%s\"\t# %s", name, new_value, comment);
			else
				Utils.sprintf (buffer, "\ng:sp_%s = \"%s\"", name, new_value);
		}
		else {
			if (comment != null)
				Utils.sprintf (buffer, "\ng:sp_%s = %s\t# %s", name, new_value, comment);
			else
				Utils.sprintf (buffer, "\ng:sp_%s = %s", name, new_value);
		}
		sb.insert (idx - 1, str_find);
	}
}
