public class Achievements {

	private Supravim.Ach.Defs  defs  = new Supravim.Ach.Defs ();
	private Supravim.Ach.State state = new Supravim.Ach.State ();

	private string inbox_path = Path.build_filename (
		Environment.get_user_config_dir (), "supravim", "achievements.inbox");

	private HashTable<string, bool> session_lsp = new HashTable<string, bool> (str_hash, str_equal);

	private int64 session_start = 0;
	private int64 last_activity = 0;
	private int   theme_session = 0;
	private int   session_ctrl_cv = 0;
	private Queue<int64?> write_times = new Queue<int64?> ();

	public Achievements () {
		session_start = now ();
		state.roll_day ();
		drain_inbox ();
		evaluate_all ();
		save_if_dirty ();
		Timeout.add_seconds (30, () => {
			state.roll_day ();
			drain_inbox ();
			evaluate_all ();
			save_if_dirty ();
			return Source.CONTINUE;
		});
	}

	~Achievements () {
		save_if_dirty ();
	}

	public void add_metric (string name, int64 delta) {
		touch_activity ();
		state.add (name, delta, defs.is_max_metric (name));

		if (name == "ctrl_cv")
			session_ctrl_cv += (int) delta;
		if (name == "theme_change")
			theme_session += (int) delta;
		if (name == "write")
			write_times.push_tail (now ());

		evaluate_all ();
	}

	public void force_unlock (string id) {
		unowned var d = defs.get_by_id (id);
		if (d != null)
			award (d);
	}

	public void add_lang (string ft) {
		if (state.add_lang (ft))
			evaluate_all ();
	}

	public void mark_lsp (string name) {
		if (name == "")
			return;
		session_lsp[name] = true;
		state.add_lsp_ready (name);
		evaluate_all ();
	}

	public void on_quit () {
		if (now () - session_start < 10)
			force_unlock ("alcatraz");

		if (session_ctrl_cv == 0 && state.counter ("write") > 0)
			force_unlock ("sevrage_reussi");
	}

	private static int64 now () {
		return get_real_time () / 1000000;
	}

	private void save_if_dirty () {
		if (state.dirty || state.history_dirty)
			state.save ();
	}

	private void touch_activity () {
		int64 n = now ();
		if (last_activity > 0) {
			int64 gap = n - last_activity;
			if (gap > 0 && gap <= 120)
				state.add_today ("active_sec", gap);
		}
		last_activity = n;
		if (!state.has_today ("first_min")) {
			var dt = new DateTime.now_local ();
			state.set_today ("first_min", dt.get_hour () * 60 + dt.get_minute ());
		}
	}

	private void drain_inbox () {
		if (!FileUtils.test (inbox_path, FileTest.EXISTS))
			return;

		string work = inbox_path + ".draining";
		if (FileUtils.rename (inbox_path, work) != 0)
			return;

		string data;
		try { FileUtils.get_contents (work, out data); }
		catch (Error e) { FileUtils.unlink (work); return; }
		FileUtils.unlink (work);

		foreach (unowned string raw in data.split ("\n")) {
			string line = raw.strip ();
			if (line == "")
				continue;
			string[] p = Regex.split_simple ("\\s+", line);
			if (p.length < 2)
				continue;
			if (p[0] == "M") {
				int64 n = p.length >= 3 ? int64.parse (p[2]) : 1;
				add_metric (p[1], n);
			} else if (p[0] == "E") {
				force_unlock (p[1]);
			} else if (p[0] == "L") {
				add_lang (p[1]);
			}
		}
	}

	private void evaluate_all () {
		foreach (unowned Supravim.Ach.Def d in defs.list.data) {
			if (state.is_unlocked (d.id))
				continue;

			if (d.metric != null) {
				int64 val = d.daily ? state.today_value (d.metric) : state.counter (d.metric);
				if (val >= d.target)
					award (d);
				continue;
			}

			if (d.special == null)
				continue;
			switch (d.special) {
			case "session":
				if (now () - session_start >= d.arg) award (d);
				break;
			case "insomniac":
				if (local_hour () >= 2 && local_hour () < 5) award (d);
				break;
			case "early_bird":
				if (local_hour () < 7) award (d);
				break;
			case "streak":
				if (state.streak >= d.arg) award (d);
				break;
			case "distinct_days":
				if (state.distinct_days >= d.arg) award (d);
				break;
			case "distinct_langs":
				if (state.langs_count >= d.arg) award (d);
				break;
			case "lsp_count":
				if (state.lsp_ready_count >= d.arg) award (d);
				break;
			case "session_lsp_count":
				if (session_lsp.size () >= d.arg) award (d);
				break;
			case "same_hour_streak":
				if (same_hour_streak_ok (d.arg)) award (d);
				break;
			case "friday_13":
				if (is_friday_13 () && state.today_value ("active_sec") > 0) award (d);
				break;
			case "theme_session":
				if (theme_session >= d.arg) award (d);
				break;
			case "write_rate":
				if (write_rate_count (d.arg) >= d.count) award (d);
				break;
			case "ratio":
				if (ratio_ok (d.arg, d.min_words)) award (d);
				break;
			case "legend":
				if (all_others_unlocked (d.id)) award (d);
				break;
			}
		}
	}

	private bool ratio_ok (int64 threshold, int64 min_words) {
		if (state.counter ("words") < min_words)
			return false;
		int64 ins = state.counter ("insert_ms");
		int64 nor = state.counter ("normal_ms");
		int64 total = ins + nor;
		if (total < 600000)
			return false;
		return (ins * 100) / total < threshold;
	}

	private int write_rate_count (int64 window) {
		int64 n = now ();
		while (!write_times.is_empty () && n - write_times.peek_head () > window)
			write_times.pop_head ();
		return (int) write_times.get_length ();
	}

	private bool is_friday_13 () {
		var dt = new DateTime.now_local ();
		return dt.get_day_of_month () == 13 && dt.get_day_of_week () == 5;
	}

	private bool same_hour_streak_ok (int64 need) {
		int64 lo = int64.MAX, hi = int64.MIN;
		int count = 0;
		var day = new DateTime.now_local ();
		while (true) {
			string ds = day.format ("%Y-%m-%d");
			if (!state.has_day (ds, "first_min"))
				break;
			int64 m = state.day_value (ds, "first_min");
			lo = int64.min (lo, m);
			hi = int64.max (hi, m);
			if (hi - lo > 60)
				break;
			count++;
			if (count >= need)
				return true;
			day = day.add_days (-1);
		}
		return false;
	}

	private bool all_others_unlocked (string self_id) {
		foreach (unowned Supravim.Ach.Def d in defs.list.data)
			if (d.id != self_id && !state.is_unlocked (d.id))
				return false;
		return true;
	}

	private void award (Supravim.Ach.Def d) {
		if (state.is_unlocked (d.id))
			return;
		state.unlock (d.id);
		state.save ();
		stdout.printf ("AchievementUnlocked: %s|%s|%s|%s\n", d.id, d.icon, d.title, d.desc);
		stdout.flush ();

		if (d.special != "legend")
			evaluate_legend ();
	}

	private void evaluate_legend () {
		foreach (unowned Supravim.Ach.Def d in defs.list.data)
			if (d.special == "legend" && !state.is_unlocked (d.id) && all_others_unlocked (d.id))
				award (d);
	}

	private int local_hour () {
		return new DateTime.now_local ().get_hour ();
	}
}
