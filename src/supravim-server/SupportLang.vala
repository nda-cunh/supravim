
public struct Support {
	string allowed;
	string package_name;
	string bundle;
	string filetype;
}

public class SupportLang {
	public const Support[] all_packages = {
		{ "c3,c3i", "plugin-lang-c3", "lang-c3", "c3"},
		{ "vala,vapi", "plugin-lang-vala", "lang-vala", "vala"},
		{ "blp,blueprint", "plugin-lang-blueprint", "lang-blueprint", "blp"},

	};

	public static Support? get_package_possible (string file) {
		if (is_loaded[file] != null)
			return null;
		var? suprapack_list_plugin = get_suprapack_list_plugin (); 
		if (suprapack_list_plugin == null)
			return null;

		foreach (unowned Support support in all_packages) {
			if (file in support.allowed.split (","))
			{
				if (support.package_name in suprapack_list_plugin) {
					foreach (var filetype in support.allowed.split (",")) {
						is_loaded[filetype] = support;
					}
					printerr ("The package is ever installed.. skip\n");
					return null;
				}
				return support;
			}
		}
		return null;
	}


	public static bool install_package (string package_name) {
		foreach (var support in SupportLang.all_packages) {
			if (support.package_name == package_name) {
				string dev_null;
				int wait_status;
				Process.spawn_command_line_sync ("suprapack install " + support.package_name + " --yes", out dev_null, out dev_null, out wait_status);
				foreach (var filetype in support.allowed.split (",")) {
					is_loaded[filetype] = support;
				}
				print ("LoadBundle: %s %s\n", support.bundle, support.filetype);
				break;
			}
		}
		return true;
	}



	private static HashTable<string, Support?>? _is_loaded = null;
	private static HashTable<string, Support?> is_loaded {
		get {
			if (_is_loaded == null) {
				_is_loaded = new HashTable<string, Support?> (str_hash, str_equal);
			}
			return _is_loaded;
		}
	}

}
