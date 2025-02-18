public enum PlayerType {
	NONE,
	PLAYER_X,
	PLAYER_O
}

public class Tile : Gtk.Button {

	private PlayerType _player_type = PlayerType.NONE;
	public PlayerType player_type {
		get {
			return _player_type;
		}
		set {
			_player_type = value;
			if (_player_type == PlayerType.PLAYER_X) 
				child = new Gtk.Picture.for_resource ("/data/cross.svg");
			else if (_player_type == PlayerType.PLAYER_O)
				child = new Gtk.Picture.for_resource ("/data/circle.svg");
			else
				child = null;
			queue_draw ();
		}
	}
}

public class TicTacToe : Gtk.Grid {
	private Tile buttons[9];

	construct {
		row_homogeneous = true;
		column_homogeneous = true;

		for (int i = 0; i < 9; ++i) {
			buttons[i] = new Tile();
			int	nb = i;
			buttons[nb].clicked.connect (() => {
				if (buttons[nb].player_type != PlayerType.NONE)
					return;
				buttons[nb].player_type = player_type;
				print (@"Button %d clicked $player_type\n", nb);
				player_type = (player_type == PLAYER_X) ? PlayerType.PLAYER_O : PlayerType.PLAYER_X;
			});
			attach (buttons[nb], nb % 3, nb / 3, 1, 1);
		}
	}

	public PlayerType player_type = PlayerType.PLAYER_X;
}

public class Menu : Gtk.Box {
	private Gtk.Button button_new_game;
	private Gtk.Button button_join_game;
	private Gtk.Button button_quit;

	construct {
		orientation = Gtk.Orientation.VERTICAL;
		button_new_game = new Gtk.Button.with_label ("New Game");
		button_join_game = new Gtk.Button.with_label ("Join Game");
		button_quit = new Gtk.Button.with_label ("Quit");

		button_new_game.clicked.connect (() => {
			this.new_game();
		});
		button_new_game.clicked.connect (() => {
			this.join_game();
		});
		button_quit.clicked.connect (() => {
			this.quit ();
		});
		append (button_new_game);
		append (button_join_game);
		append (button_quit);
	}

	public signal void join_game();
	public signal void new_game();
	public signal void quit();
}

public class WaitingRoom : Gtk.Box {
	construct {
		orientation = Gtk.Orientation.VERTICAL;
		var waiting = new Gtk.Label.with_mnemonic ("Waiting for other player");
		var cancel = new Gtk.Button.with_label ("Cancel");
		cancel.clicked.connect (() => {
			this.cancel();
		});
		append (waiting);
		append (cancel);
	}

	public signal void cancel();
}

public class Activity {
	private Gtk.Notebook notebook = new Gtk.Notebook ();
	private TicTacToe tic_tac_toe = new TicTacToe ();
	private Menu menu = new Menu ();
	private WaitingRoom waiting_room = new WaitingRoom ();

	public Activity () {
		notebook.append_page (menu, new Gtk.Label.with_mnemonic ("Menu"));
		notebook.append_page (waiting_room, new Gtk.Label.with_mnemonic ("Waiting Room"));
		notebook.append_page (tic_tac_toe, new Gtk.Label.with_mnemonic ("Tic Tac Toe"));

		init_event ();
	}

	private void init_event () {
		menu.quit.connect (Application.get_default ().quit);

		menu.new_game.connect (() => {
			print ("New Game\n");
		});
		menu.new_game.connect_after (notebook.next_page);

		notebook.switch_page.connect ((page, page_num) => {
			print ("Switch page %u\n", page_num);
			if (page_num == 2) {
				tic_tac_toe.player_type = PlayerType.PLAYER_X;
			}
		});
	}

	public unowned Gtk.Notebook get_widget () {
		return notebook;
	}
}

public class ExampleApp : Gtk.Application {
	construct {
		application_id = "com.example.App";
	}

	public override void activate () {
		var win = new Gtk.ApplicationWindow (this);
		win.default_width = 400;
		win.default_height = 400;
		var activity = new Activity ();

		win.child = activity.get_widget ();
		win.present ();
	}

	public static int main (string[] args) {
		var app = new ExampleApp ();
		return app.run (args);
	}
}
