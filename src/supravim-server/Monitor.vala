
public class MyMonitor {

	private uint source_id = 0;

	/**
	 * send a refresh signal to the client
	 * reset if the signal is already sent after 250ms
	 */
	private void send_refresh () {
		if (ready == false)
			return ;
		if (source_id != 0)
			Source.remove (source_id);
		source_id = Timeout.add (250, () => {
			print ("refresh\n");
			source_id = 0;
			return false;
		});
	}

	/**
	 * add a directory to the monitor list
	 */
	public void add_directory (string path) {
		try {
			File file = File.new_for_path (path);
			FileMonitor monitor = file.monitor(FileMonitorFlags.NONE, null);
			monitors += monitor;
			monitor.changed.connect (this.onChangeState);
		}
		catch (Error e) {
			printerr ("Error: %s\n", e.message);
		}
	}

	public void onChangeState(File src, File? dest, FileMonitorEvent event) {
		if (event == FileMonitorEvent.CREATED || event == FileMonitorEvent.DELETED)
		{
			var filename = Path.get_basename (src.get_path());
			if (src.get_path().has_suffix("~") || src.get_path().has_suffix (".o"))
				return ;
			if ("compile_commands.json" in src.get_path ())
				return ;
			if (filename.has_prefix ("."))
				return ;
			if (regex_nb.match(filename))
				return ;
			if (event == FileMonitorEvent.DELETED) {
				if (FileUtils.test (src.get_path (), FileTest.EXISTS) == false)
					send_refresh ();
			}
			else 
				send_refresh ();
			if (FileUtils.test (src.get_path (), FileTest.IS_DIR))
				add_directory (src.get_path ());
		}
	}

	private void search_directory (string path, int depth = 0) {
		if (depth > depth_max)
			return ;
		string basename = Path.get_basename (path);
		if (basename[0] == '.')
			return ;
		try {
			var dir = Dir.open (path);
			unowned string? file_name;
			while ((file_name = dir.read_name ()) != null) {
				if (FileUtils.test (Path.build_filename (path, file_name), FileTest.IS_DIR))
					search_directory (Path.build_filename (path, file_name), depth + 1);
			}
			this.add_directory (path);
		}
		catch (Error e) {
			printerr ("Error: %s\n", e.message);
		}	
	}


	/**
	 * stdin_pipe
	 * This function will read the stdin and send the data to the onStdin signal
	 */
	public async void stdin_pipe () {

		var stdin_channel = new IOChannel.unix_new(0);

        stdin_channel.add_watch(IOCondition.IN, (channel, condition) => {
            string data = null;
			size_t length = 0;
			size_t terminaison = 0;
            try {
                channel.read_line (out data, out length, out terminaison);
            } catch (Error e) {
                stderr.printf("Erreur de lecture : %s\n", e.message);
                return false;
            }
			onStdin (data);
            return true;
        });
		yield;
	}
	
	/**
	 * onStdin
	 * This signal is emitted when a new line is read from the stdin
	 */
	public signal void onStdin(string line);


	/**
	 * run in async
	 * This function will start the monitor
	 */
	public async void run () {
		stdin_pipe.begin ();
		yield;
	}
	
	private Regex regex_nb = /^[0-9]*$/;
	private FileMonitor []monitors;
	private int depth_max = 10;
	private bool ready = false;

	public MyMonitor (owned string path) {
		Timeout.add (1000, () => {
			ready = true;
			return false;
		});
		monitors = {};

		if (path[path.length - 1] == '/')
			path = path.substring (0, path.length - 1);
		if (path == Environment.get_home_dir ())
			depth_max = 4;
		search_directory (path);
	}

}
