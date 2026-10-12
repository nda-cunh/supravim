class StdinStream  {
	
	/**
	 * onStdin
	 * This signal is emitted when a new line is read from the stdin
	 */
	public signal void onStdin(string line);

	/**
	 * onClose
	 * This signal is emitted once when stdin is closed (vim exited or crashed)
	 */
	public signal void onClose();

	/**
	 * stdin_pipe
	 * This function will read the stdin and send the data to the onStdin signal
	 */
	public async void stdin_pipe () {

		var stdin_channel = new IOChannel.unix_new(0);

        stdin_channel.add_watch(IOCondition.IN | IOCondition.HUP | IOCondition.ERR, (channel, condition) => {
			string? data = null;
			size_t length = 0;
			size_t terminaison = 0;
			IOStatus status;
			try {
				status = channel.read_line (out data, out length, out terminaison);
			} catch (Error e) {
				stderr.printf(_("Read error: %s\n"), e.message);
				onClose ();
				return false;
			}
			// EOF: nobody is writing to us anymore, stop watching instead of spinning
			if (status == IOStatus.EOF || status == IOStatus.ERROR) {
				onClose ();
				return false;
			}
			if (data != null)
				onStdin (data);
			return true;
		});
		yield;
	}

	public StdinStream () {
		stdin_pipe.begin ();
	}
}
