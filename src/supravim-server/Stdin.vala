class StdinStream  {
	
	/**
	 * onStdin
	 * This signal is emitted when a new line is read from the stdin
	 */
	public signal void onStdin(string line);

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

	public StdinStream () {
		stdin_pipe.begin ();
	}
}
