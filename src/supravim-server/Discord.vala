[CCode (cname = "getpid", cheader_filename = "unistd.h")]
public extern int getpid ();

private const int MAX_PACKET_SIZE = 65536;

public class IpcConnection : SocketClient {
	public IpcConnection (string ipc_path) throws Error {
		var unix_socket_address = new UnixSocketAddress(ipc_path);
		connection = base.connect(unix_socket_address);
		input = connection.get_input_stream();
		output = connection.get_output_stream();
	}

	public async void send_packet(int opcode, string payload) throws Error {
        uint8[] data = (uint8[]) payload.data;
        var header = new uint8[8];

		Memory.copy(header, &opcode, 4);
		Memory.copy(&header[4], &data.length, 4);

        size_t written;
        yield output.write_all_async(header, Priority.DEFAULT, null, out written);
        yield output.write_all_async(data, Priority.DEFAULT, null, out written);
    }

	public async string recv_packet() throws Error {
		uint8 header[8];
		size_t read;
		yield input.read_all_async(header, Priority.DEFAULT, null, out read);
		if (read != 8)
			throw new IOError.FAILED ("Discord IPC: connection closed");

		int opcode = 0;
		int length = 0;
		Memory.copy(&opcode, header, 4);
		Memory.copy(&length, &header[4], 4);

		if (length <= 0)
			return "";
		if (length > MAX_PACKET_SIZE)
			throw new IOError.INVALID_ARGUMENT ("Discord IPC: packet too large (%d bytes)".printf (length));
		var payload = new uint8[length + 1];
		yield input.read_all_async(payload[0:length], Priority.DEFAULT, null, out read);

		return (string)payload;
	}

	private SocketConnection connection;
	private OutputStream output; 
	private InputStream input;
}
 
// Escape a string for use inside a JSON string literal (file names can contain " or \\)
private string json_escape (string s) {
	var sb = new StringBuilder.sized (s.length + 8);
	for (int i = 0; i < s.length; i++) {
		uint8 c = (uint8) s[i];
		switch (c) {
			case '"':  sb.append ("\\\""); break;
			case '\\': sb.append ("\\\\"); break;
			case '\n': sb.append ("\\n"); break;
			case '\r': sb.append ("\\r"); break;
			case '\t': sb.append ("\\t"); break;
			default:
				if (c < 0x20)
					sb.append_printf ("\\u%04x", c);
				else
					sb.append_c ((char) c);
				break;
		}
	}
	return sb.str;
}

public class DiscordIpc {
	IpcConnection socket_client;
	string client_id;
	public DiscordIpc (string client_id) throws Error {
		socket_client = new IpcConnection(get_ipc_path());
		this.client_id = client_id;
	}

	public time_t start_time { get; private set; default = time_t(); }
	public string state { get; set; default = "In Game"; }
	public string details { get; set; default = "Playing a Game"; }
	public string large_image { get; set; default = "large_image_key"; }
	public string large_text { get; set; default = "Large Image Text"; }
	public string small_image { get; set; default = "small_image_key"; }
	public string small_text { get; set; default = "Small Image Text"; }
	public bool is_ready { get; private set; default = false; }

	public async void send_actvity () throws Error {
		var try = 0;
		do { 
			Timeout.add(500, send_actvity.callback);
			yield;

			++try;
			if (try > 10) {
				printerr ("DiscordIpc: Timeout waiting for ready state\n");
				return;
			}
		} while (!is_ready);

		var activity_str = """
		{
			"state": "%s",
			"details": "%s",
			"details_url": "https://gitlab.com/nda-cunh/SupraVim",
			"timestamps": {
				"start": %ld
			},
			"assets": {
				"large_image": "%s",
				"large_text": "%s",
				"large_url": "https://gitlab.com/nda-cunh/SupraVim"
			}
		}
		""".printf(json_escape (state), json_escape (details), start_time, json_escape (large_image), json_escape (large_text));

		var activity_json = """ 
		{
			"cmd": "SET_ACTIVITY",
			"args": {
				"activity": %s,
				"pid": %d
			},
			"nonce": "%s"
		}
		""".printf(activity_str, getpid(), Uuid.string_random());
		yield socket_client.send_packet(1, activity_json);
		var response = yield socket_client.recv_packet();
		printerr ("Set Activity response: %s\n", response);
	}


	public async void run () throws Error {
		var handshake = """{"v":1,"client_id":"%s"}""".printf(client_id);
		yield socket_client.send_packet(0, handshake);

		var response = yield socket_client.recv_packet();
		printerr ("Handshake response: %s\n", response);
		is_ready = true;
	}


	private string get_ipc_path(int id = 0) {
        string base_dir = Environment.get_variable("XDG_RUNTIME_DIR")
            ?? Environment.get_variable("TMPDIR")
            ?? Environment.get_variable("TMP")
            ?? Environment.get_variable("TEMP")
            ?? "/tmp";

		// for flatpak
		if (FileUtils.test(base_dir + "/app/com.discordapp.Discord", FileTest.IS_DIR)) {
			base_dir = base_dir + "/app/com.discordapp.Discord";
		}

        return base_dir + "/discord-ipc-" + id.to_string();
    }

}


public class DiscordSupraVim : DiscordIpc {
	public DiscordSupraVim (string client_id) throws Error {
		base(client_id);
	}

	// Get the filetype vim of the filename or the extension
	public void open_file(string filetype, string filename) {
		if (filename.has_suffix (".h") || filename.has_suffix (".c"))
			change_image("cc");
		else if (filename == ".gitlab-ci.yml" || filename == ".gitlab-ci.yaml")
			change_image("gitlab");
		else if (filename == "Makefile")
			change_image("makefile");
		else {
			switch (filetype) {
				case "suprawater":
					return;
				default:
					change_image(filetype);
					break;
			}
		}

		details = "SupraEdit " + filetype + " file";
		base.state = "Editing " + filename;

		send_actvity.begin();
	}

	private void change_image (string image) {
		large_image = image;
		small_image = "supravim_mini";
		large_text = image;
		small_text = "supravim";
	}
}
