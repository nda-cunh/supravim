public errordomain ErrorOption {
	OPTION_NOT_FOUND,
	INCOMPATIBLE_OPTION_TYPE,
}

enum OptionType {
	STRING,
	NUMBER,
	BOOLEAN
}

namespace Modificator {
	// ------------ UPDATE BOOLEAN OPTION ------------ //

	public void	enable(string var_name) throws Error {
		Modificator.update_bool(var_name, "true");
		print(@"$var_name: \033[1;92menabled\033[m\n");
	}

	public void	disable(string var_name) throws Error {
		Modificator.update_bool(var_name, "false");
		print(@"$var_name: \033[1;91mdisabled\033[m\n");
	}

	private void	check_option_validity(string var_name, OptionType type) {
		var option_sp = General.get();

		if (!option_sp.contains(var_name))
			throw new ErrorOption.OPTION_NOT_FOUND(@"$var_name: option not found.");

		if (/(true|false)/.match(option_sp[var_name].value, 0, null));

	}

	private void	update_bool(string var_name, string new_value) throws Error {
		var option_sp = General.get();

		if (!option_sp.contains(var_name))
			throw new ErrorOption.OPTION_NOT_FOUND(@"$var_name: option not found.");
		else if (option_sp[var_name].value != "true" && option_sp[var_name].value != "false")
			throw new ErrorOption.INCOMPATIBLE_OPTION_TYPE(@"$var_name: not a boolean.");
		
		// Regex to match the option line
		var opt_regex = new Regex(@"^g:sp_$var_name.+?\n", RegexCompileFlags.DOTALL|RegexCompileFlags.MULTILINE);

		// Construct new line with the value
		var replacement = @"g:sp_$(var_name) = $new_value\n";
		if (option_sp[var_name].comment != null)
			replacement = @"g:sp_$(var_name) = $new_value\t# $(option_sp[var_name].comment)\n";

		// Get file content
		string contents;
		FileUtils.get_contents (option_sp[var_name].file, out contents);

		// Replace contents with new value
		contents = opt_regex.replace(contents, -1, 0, replacement, 0);
		FileUtils.set_contents(option_sp[var_name].file, contents);	
	}
}
