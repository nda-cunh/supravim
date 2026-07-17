public class AchDef {
	public string  id;
	public string  cat;
	public string  icon;
	public string  title;
	public string  desc;
	public string? metric  = null;
	public bool    daily   = false;
	public bool    is_max  = false;
	public int64   target  = 0;
	public string? special   = null;
	public int64   arg       = 0;
	public int64   min_words = 0;
}

public class Achievements {

	private string state_path = Path.build_filename (
		Environment.get_user_config_dir (), "supravim", "achievements.json");

	private string inbox_path = Path.build_filename (
		Environment.get_user_config_dir (), "supravim", "achievements.inbox");

	private GenericArray<AchDef> defs = new GenericArray<AchDef> ();

	private HashTable<string, int64?> counters   = new HashTable<string, int64?> (str_hash, str_equal);
	private HashTable<string, HashTable<string, int64?>> history =
		new HashTable<string, HashTable<string, int64?>> (str_hash, str_equal);
	private HashTable<string, int64?> daily       = new HashTable<string, int64?> (str_hash, str_equal);
	private HashTable<string, string> unlocked    = new HashTable<string, string> (str_hash, str_equal);
	private HashTable<string, bool>   langs        = new HashTable<string, bool> (str_hash, str_equal);
	private HashTable<string, bool>   lsp_ready     = new HashTable<string, bool> (str_hash, str_equal);
	private HashTable<string, bool>   session_lsp   = new HashTable<string, bool> (str_hash, str_equal);

	private string daily_date     = "";
	private string last_day        = "";
	private int64  streak          = 0;
	private int64  best_streak      = 0;
	private int64  distinct_days     = 0;

	private int64  session_start = 0;
	private int64  last_activity  = 0;
	private int    theme_session = 0;
	private int    session_ctrl_cv = 0;
	private Queue<int64?> write_times = new Queue<int64?> ();

	private bool dirty = false;

	public Achievements () {
		session_start = get_real_time () / 1000000;
		load_defs ();
		load_state ();
		ensure_today ();
		drain_inbox ();
		evaluate_all ();
		save ();
		Timeout.add_seconds (30, () => {
			ensure_today ();
			drain_inbox ();
			evaluate_all ();
			if (dirty) save ();
			return Source.CONTINUE;
		});
	}

	~Achievements () {
		if (dirty) save ();
	}

	public void add_metric (string name, int64 delta) {
		ensure_today ();
		touch_activity ();
		if (name in max_metrics) {
			counters[name] = int64.max (get_counter (name), delta);
			daily[name] = int64.max (get_daily (name), delta);
		} else {
			counters[name] = get_counter (name) + delta;
			daily[name] = get_daily (name) + delta;
		}

		if (name == "ctrl_cv")
			session_ctrl_cv += (int) delta;
		if (name == "theme_change")
			theme_session += (int) delta;
		if (name == "write")
			register_write ();

		dirty = true;
		evaluate_all ();
	}

	public void force_unlock (string id) {
		foreach (unowned AchDef d in defs.data)
			if (d.id == id) { award (d); return; }
	}

	public void add_lang (string ft) {
		if (ft == "" || ft in langs) return;
		langs[ft] = true;
		dirty = true;
		evaluate_all ();
	}

	public void mark_lsp (string name) {
		if (name == "") return;
		session_lsp[name] = true;
		if (name in lsp_ready) { evaluate_all (); return; }
		lsp_ready[name] = true;
		dirty = true;
		evaluate_all ();
	}

	private void touch_activity () {
		int64 now = get_real_time () / 1000000;
		if (last_activity > 0) {
			int64 gap = now - last_activity;
			if (gap > 0 && gap <= 120)
				daily["active_sec"] = get_daily ("active_sec") + gap;
		}
		last_activity = now;
		if (daily["first_min"] == null) {
			var dt = new DateTime.now_local ();
			daily["first_min"] = dt.get_hour () * 60 + dt.get_minute ();
		}
	}

	private void drain_inbox () {
		if (!FileUtils.test (inbox_path, FileTest.EXISTS)) return;

		string work = inbox_path + ".draining";
		if (FileUtils.rename (inbox_path, work) != 0) return;

		string data;
		try { FileUtils.get_contents (work, out data); }
		catch (Error e) { FileUtils.unlink (work); return; }
		FileUtils.unlink (work);

		foreach (unowned string raw in data.split ("\n")) {
			string line = raw.strip ();
			if (line == "") continue;
			string[] p = Regex.split_simple ("\\s+", line);
			if (p.length == 0) continue;
			if (p[0] == "M" && p.length >= 2) {
				int64 n = p.length >= 3 ? int64.parse (p[2]) : 1;
				add_metric (p[1], n);
			} else if (p[0] == "E" && p.length >= 2) {
				force_unlock (p[1]);
			} else if (p[0] == "L" && p.length >= 2) {
				add_lang (p[1]);
			}
		}
	}

	public void on_quit () {
		if ((get_real_time () / 1000000) - session_start < 10)
			unlock_by_id ("alcatraz");

		if (session_ctrl_cv == 0 && get_counter ("write") > 0)
			unlock_by_id ("sevrage_reussi");
	}

	private void evaluate_all () {
		foreach (unowned AchDef d in defs.data) {
			if (d.id in unlocked) continue;

			if (d.metric != null) {
				int64 val = d.daily ? get_daily (d.metric) : get_counter (d.metric);
				if (val >= d.target) award (d);
				continue;
			}

			if (d.special == null) continue;
			switch (d.special) {
			case "session":
				if ((get_real_time () / 1000000) - session_start >= d.arg) award (d);
				break;
			case "insomniac":
				if (local_hour () >= 2 && local_hour () < 5) award (d);
				break;
			case "early_bird":
				if (local_hour () < 7) award (d);
				break;
			case "streak":
				if (streak >= d.arg) award (d);
				break;
			case "distinct_days":
				if (distinct_days >= d.arg) award (d);
				break;
			case "distinct_langs":
				if (langs.size () >= d.arg) award (d);
				break;
			case "lsp_count":
				if (lsp_ready.size () >= d.arg) award (d);
				break;
			case "session_lsp_count":
				if (session_lsp.size () >= d.arg) award (d);
				break;
			case "same_hour_streak":
				if (same_hour_streak_ok (d.arg)) award (d);
				break;
			case "friday_13":
				if (is_friday_13 () && get_daily ("active_sec") > 0) award (d);
				break;
			case "theme_session":
				if (theme_session >= d.arg) award (d);
				break;
			case "write_rate":
				if (write_rate_count (d.arg) >= 50) award (d);
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
		if (get_counter ("words") < min_words) return false;
		int64 ins = get_counter ("insert_ms");
		int64 nor = get_counter ("normal_ms");
		int64 total = ins + nor;
		if (total < 600000) return false;
		return (ins * 100) / total < threshold;
	}

	private int write_rate_count (int64 window) {
		int64 now = get_real_time () / 1000000;

		while (!write_times.is_empty () && now - write_times.peek_head () > window)
			write_times.pop_head ();
		return (int) write_times.get_length ();
	}

	private void register_write () {
		write_times.push_tail (get_real_time () / 1000000);
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
			unowned var b = history[day.format ("%Y-%m-%d")];
			if (b == null || b["first_min"] == null) break;
			int64 m = b["first_min"];
			lo = int64.min (lo, m);
			hi = int64.max (hi, m);
			if (hi - lo > 60) break;
			count++;
			if (count >= need) return true;
			day = day.add_days (-1);
		}
		return false;
	}

	private bool all_others_unlocked (string self_id) {
		foreach (unowned AchDef d in defs.data)
			if (d.id != self_id && !(d.id in unlocked))
				return false;
		return true;
	}

	private void unlock_by_id (string id) {
		foreach (unowned AchDef d in defs.data)
			if (d.id == id) { award (d); return; }
	}

	private void award (AchDef d) {
		if (d.id in unlocked) return;
		unlocked[d.id] = today_str ();
		dirty = true;
		save ();
		stdout.printf ("AchievementUnlocked: %s|%s|%s|%s\n", d.id, d.icon, d.title, d.desc);
		stdout.flush ();

		if (d.special != "legend")
			evaluate_legend ();
	}

	private void evaluate_legend () {
		foreach (unowned AchDef d in defs.data)
			if (d.special == "legend" && !(d.id in unlocked) && all_others_unlocked (d.id))
				award (d);
	}

	private void ensure_today () {
		string today = today_str ();
		if (daily_date == today) return;
		daily_date = today;
		daily = bucket_for (today);
		rollover_day (today);
		distinct_days = (int64) history.size ();
	}

	private unowned HashTable<string, int64?> bucket_for (string date) {
		unowned HashTable<string, int64?> bucket = history[date];
		if (bucket == null) {
			var created = new HashTable<string, int64?> (str_hash, str_equal);
			bucket = created;
			history[date] = (owned) created;
		}
		return bucket;
	}

	private void rollover_day (string today) {
		if (last_day == today) return;
		if (last_day == "") {
			streak = 1;
		} else {
			if (last_day == yesterday_str ())
				streak += 1;
			else
				streak = 1;
		}
		last_day = today;
		if (streak > best_streak)
			best_streak = streak;
		dirty = true;
	}

	private HashTable<string, bool> max_metrics = new HashTable<string, bool> (str_hash, str_equal);

	private int64 get_counter (string k) { return counters[k] ?? 0; }
	private int64 get_daily   (string k) { return daily[k]    ?? 0; }

	private int local_hour () { return new DateTime.now_local ().get_hour (); }
	private string today_str () { return new DateTime.now_local ().format ("%Y-%m-%d"); }
	private string yesterday_str () {
		return new DateTime.now_local ().add_days (-1).format ("%Y-%m-%d");
	}

	private void load_defs () {
		string? path = find_defs_file ();
		if (path == null) return;
		string data;
		try { FileUtils.get_contents (path, out data); }
		catch (Error e) { return; }

		var doc = YYJson.Doc.read (data, data.length);
		if (doc == null) return;
		unowned var arr = doc.get_root ().obj_get ("achievements");
		if (arr == null) return;

		for (size_t i = 0; i < arr.arr_size (); i++) {
			unowned var e = arr.arr_get (i);
			unowned var id_v = e.obj_get ("id");
			if (id_v == null) continue;

			var d = new AchDef ();
			d.id    = id_v.get_str ();
			d.cat   = str_field (e, "cat");
			d.icon  = str_field (e, "icon");
			d.title = str_field (e, "title");
			d.desc  = str_field (e, "desc");

			unowned var metric_v  = e.obj_get ("metric");
			unowned var target_v  = e.obj_get ("target");
			unowned var daily_v   = e.obj_get ("daily");
			unowned var mode_v    = e.obj_get ("mode");
			unowned var special_v = e.obj_get ("special");

			if (metric_v != null) {
				d.metric = metric_v.get_str ();
				if (target_v != null) d.target = target_v.get_sint ();
				if (daily_v != null)  d.daily  = daily_v.get_bool ();
				if (mode_v != null && mode_v.get_str () == "max") {
					d.is_max = true;
					max_metrics[d.metric] = true;
				}
			}
			if (special_v != null) {
				d.special = special_v.get_str ();
				d.arg = special_arg (e, d.special);
			}
			unowned var min_words_v = e.obj_get ("min_words");
			if (min_words_v != null) d.min_words = min_words_v.get_sint ();
			defs.add (d);
		}
	}

	private int64 special_arg (YYJson.Value e, string special) {
		string key;
		switch (special) {
		case "session":        key = "seconds"; break;
		case "streak":         key = "days";    break;
		case "same_hour_streak": key = "days";  break;
		case "session_lsp_count": key = "count"; break;
		case "distinct_days":  key = "days";    break;
		case "distinct_langs": key = "langs";   break;
		case "ratio":          key = "ratio";   break;
		case "write_rate":     key = "window";  break;
		case "theme_session":  key = "count";   break;
		case "lsp_count":      key = "count";   break;
		default:               return 0;
		}
		unowned var v = e.obj_get (key);
		return v != null ? v.get_sint () : 0;
	}

	private string str_field (YYJson.Value e, string key) {
		unowned var v = e.obj_get (key);
		return v != null ? v.get_str () : "";
	}

	private string? find_defs_file () {
		string user = Path.build_filename (
			Environment.get_user_data_dir (), "supravim", "achievements.json");
		if (FileUtils.test (user, FileTest.EXISTS)) return user;
		foreach (unowned string sys in Environment.get_system_data_dirs ()) {
			string p = Path.build_filename (sys, "supravim", "achievements.json");
			if (FileUtils.test (p, FileTest.EXISTS)) return p;
		}
		return null;
	}

	private void load_state () {
		if (!FileUtils.test (state_path, FileTest.EXISTS)) return;
		string data;
		try { FileUtils.get_contents (state_path, out data); }
		catch (Error e) { return; }

		var doc = YYJson.Doc.read (data, data.length);
		if (doc == null) return;
		unowned var root = doc.get_root ();

		load_int_map (root.obj_get ("counters"), counters);
		load_str_map (root.obj_get ("unlocked"), unlocked);
		load_str_set (root.obj_get ("langs"), langs);
		load_str_set (root.obj_get ("lsp_ready"), lsp_ready);

		unowned var hist = root.obj_get ("history");
		if (hist != null) {
			YYJson.ObjIter it;
			if (YYJson.ObjIter.init (hist, out it)) {
				unowned YYJson.Value? key;
				while ((key = it.next ()) != null) {
					var bucket = new HashTable<string, int64?> (str_hash, str_equal);
					load_int_map (YYJson.ObjIter.get_val (key), bucket);
					history[key.get_str ()] = (owned) bucket;
				}
			}
		}

		unowned var daily_o = root.obj_get ("daily");
		if (daily_o != null) {
			unowned var date_v = daily_o.obj_get ("date");
			if (date_v != null) {
				var bucket = new HashTable<string, int64?> (str_hash, str_equal);
				load_int_map (daily_o.obj_get ("values"), bucket);
				history[date_v.get_str ()] = (owned) bucket;
			}
		}

		unowned var meta = root.obj_get ("meta");
		if (meta != null) {
			unowned var last_v   = meta.obj_get ("last_day");
			unowned var streak_v = meta.obj_get ("streak");
			unowned var best_v   = meta.obj_get ("best_streak");
			unowned var days_v   = meta.obj_get ("distinct_days");
			if (last_v   != null) last_day      = last_v.get_str ();
			if (streak_v != null) streak        = streak_v.get_sint ();
			if (best_v   != null) best_streak   = best_v.get_sint ();
			if (days_v   != null) distinct_days = days_v.get_sint ();
		}
	}

	private void load_int_map (YYJson.Value? obj, HashTable<string, int64?> dest) {
		if (obj == null) return;
		YYJson.ObjIter iter;
		if (!YYJson.ObjIter.init (obj, out iter)) return;
		unowned YYJson.Value? key;
		while ((key = iter.next ()) != null) {
			unowned var val = YYJson.ObjIter.get_val (key);
			if (val != null) dest[key.get_str ()] = val.get_sint ();
		}
	}

	private void load_str_map (YYJson.Value? obj, HashTable<string, string> dest) {
		if (obj == null) return;
		YYJson.ObjIter iter;
		if (!YYJson.ObjIter.init (obj, out iter)) return;
		unowned YYJson.Value? key;
		while ((key = iter.next ()) != null) {
			unowned var val = YYJson.ObjIter.get_val (key);
			if (val != null) dest[key.get_str ()] = val.get_str ();
		}
	}

	private void load_str_set (YYJson.Value? arr, HashTable<string, bool> dest) {
		if (arr == null) return;
		for (size_t i = 0; i < arr.arr_size (); i++) {
			unowned var v = arr.arr_get (i);
			if (v != null) dest[v.get_str ()] = true;
		}
	}

	private void save () {
		dirty = false;
		try {
			DirUtils.create_with_parents (Path.get_dirname (state_path), 0755);
		} catch (Error e) { }

		var doc = new YYJson.MutDoc ();
		unowned var root = doc.obj ();
		doc.set_root (root);

		root.obj_add_val (doc, "counters",  int_map_obj (doc, counters));
		root.obj_add_val (doc, "unlocked",  str_map_obj (doc, unlocked));
		root.obj_add_val (doc, "langs",     str_set_arr (doc, langs));
		root.obj_add_val (doc, "lsp_ready", str_set_arr (doc, lsp_ready));

		unowned var hist = doc.obj ();
		history.foreach ((date, bucket) => {
			hist.obj_add_val (doc, date, int_map_obj (doc, bucket));
		});
		root.obj_add_val (doc, "history", hist);

		unowned var meta = doc.obj ();
		meta.obj_add_str (doc, "last_day", last_day);
		meta.obj_add_int (doc, "streak", streak);
		meta.obj_add_int (doc, "best_streak", best_streak);
		meta.obj_add_int (doc, "distinct_days", distinct_days);
		root.obj_add_val (doc, "meta", meta);

		string? json = doc.write (YYJson.WRITE_PRETTY);
		if (json != null) {
			try { FileUtils.set_contents (state_path, json); }
			catch (Error e) { }
		}
	}

	private unowned YYJson.MutValue int_map_obj (YYJson.MutDoc doc, HashTable<string, int64?> src) {
		unowned var o = doc.obj ();
		src.foreach ((k, v) => o.obj_add_int (doc, k, v));
		return o;
	}

	private unowned YYJson.MutValue str_map_obj (YYJson.MutDoc doc, HashTable<string, string> src) {
		unowned var o = doc.obj ();
		src.foreach ((k, v) => o.obj_add_str (doc, k, v));
		return o;
	}

	private unowned YYJson.MutValue str_set_arr (YYJson.MutDoc doc, HashTable<string, bool> src) {
		unowned var a = doc.arr ();
		src.foreach ((k, v) => a.arr_add_str (doc, k));
		return a;
	}
}
