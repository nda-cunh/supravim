/**
 * Supravim - Server
 *
 * this is the server part of the supravim project
 * it will be used to manage the files and the users
 * refresh the tree view and the file view
 *
 * And return the good Lsp for the language
 *
 **/

public class SupraVim {
	public static SourceFunc? main_loop = null;
	MyMonitor monitor;
	StdinStream stdin;
	Command command;
#if DISCORD_PRESENCE
	public static DiscordSupraVim discord;
#endif

	private SupraVim (string [] args) throws Error {
		monitor = new MyMonitor (args[1]);
		stdin = new StdinStream ();
		command = new Command ();

#if DISCORD_PRESENCE
		// Discord Rich Presence
		try {
			discord = new DiscordSupraVim ("1399862365800894584");
			discord.state = "Opening Supravim";
			discord.details = "Editing code";
			discord.large_image = "vala";
			discord.run.begin ( () => discord.send_actvity.begin());
		}
		catch (Error e) {
			printerr ("Discord Error: %s\n", e.message);
		}
#endif
	}

	private async void run () {
		main_loop = run.callback;
		stdin.onStdin.connect (getInputRaw);

		yield;
	}

	public static async int main (string[] args) {
		try {
			var supravim = new SupraVim (args);
			yield supravim.run ();
		}
		catch (Error e) {
			printerr ("Error: %s\n", e.message);
			return 1;
		}
		return 0;
	}

	/**
	* getInputRaw - Get the input from the client (vim) with a pipe
	*
	* @param message: the message received from the client (vim)
	*/
	private void getInputRaw (string message) {
		// Send when a file is opened
		// Format: OpenFile: <filename>
		if (message.has_prefix ("QUIT")) {
			command.OnQuit ();
		}
		// Format: LspReady
		else if (message.has_prefix ("LspReady")) {
			command.OnLspReady ();
		}
		// Format: OpenFile: <filetype>|<filename>
		else if (message.has_prefix ("OpenFile: ")) {
			command.OnOpenFile (message);
		}
		// Format:  Install: <lsp_name> <package_name>
		else if (message.has_prefix("Install: ")) {
			command.OnInstall (message);
		}
	}
}
