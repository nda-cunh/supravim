namespace Supravim.Ach {

	public class Def : Object {
		public string  id        { get; set; default = ""; }
		public string  cat       { get; set; default = ""; }
		public string  icon      { get; set; default = ""; }
		public string  title     { get; set; default = ""; }
		public string  desc      { get; set; default = ""; }
		public bool    hidden    { get; set; default = false; }
		public string? metric    { get; set; default = null; }
		public bool    daily     { get; set; default = false; }
		public bool    is_max    { get; set; default = false; }
		public int64   target    { get; set; default = 0; }
		public string? special   { get; set; default = null; }
		public int64   arg       { get; set; default = 0; }
		public int64   count     { get; set; default = 0; }
		public int64   min_words { get; set; default = 0; }
	}

	public class Category : Object {
		public string id    { get; set; default = ""; }
		public string label { get; set; default = ""; }
		public string icon  { get; set; default = ""; }
	}

	public class Defs : Object {

		private GenericArray<Def> defs = new GenericArray<Def> ();
		private GenericArray<Category> cats = new GenericArray<Category> ();
		private HashTable<string, bool> max_metrics = new HashTable<string, bool> (str_hash, str_equal);

		public unowned GenericArray<Def> list { get { return defs; } }
		public unowned GenericArray<Category> categories { get { return cats; } }

		public Defs () {
			string? path = find_file ();
			if (path == null)
				return;
			string data;
			try { FileUtils.get_contents (path, out data); }
			catch (Error e) { return; }

			var doc = YYJson.Doc.read (data, data.length);
			if (doc == null)
				return;
			unowned var root = doc.get_root ();
			if (root == null)
				return;

			load_defs (root.obj_get ("achievements"));
			load_categories (root.obj_get ("categories"));
		}

		public bool is_max_metric (string name) {
			return name in max_metrics;
		}

		public unowned Def? get_by_id (string id) {
			foreach (unowned Def d in defs.data)
				if (d.id == id)
					return d;
			return null;
		}

		public static string? find_file () {
			string user = Path.build_filename (
				Environment.get_user_data_dir (), "supravim", "achievements.json");
			if (FileUtils.test (user, FileTest.EXISTS))
				return user;
			foreach (unowned string sys in Environment.get_system_data_dirs ()) {
				string p = Path.build_filename (sys, "supravim", "achievements.json");
				if (FileUtils.test (p, FileTest.EXISTS))
					return p;
			}
			return null;
		}

		private void load_defs (YYJson.Value? arr) {
			if (arr == null)
				return;
			for (size_t i = 0; i < arr.arr_size (); i++) {
				unowned var e = arr.arr_get (i);
				unowned var id_v = e.obj_get ("id");
				if (id_v == null)
					continue;

				var d = new Def ();
				d.id     = id_v.get_str ();
				d.cat    = str_field (e, "cat");
				d.icon   = str_field (e, "icon");
				d.title  = str_field (e, "title");
				d.desc   = str_field (e, "desc");
				d.hidden = bool_field (e, "hidden");

				unowned var metric_v = e.obj_get ("metric");
				if (metric_v != null) {
					d.metric = metric_v.get_str ();
					d.target = int_field (e, "target");
					d.daily  = bool_field (e, "daily");
					unowned var mode_v = e.obj_get ("mode");
					if (mode_v != null && mode_v.get_str () == "max") {
						d.is_max = true;
						max_metrics[d.metric] = true;
					}
				}

				unowned var special_v = e.obj_get ("special");
				if (special_v != null) {
					d.special = special_v.get_str ();
					d.arg     = special_arg (e, d.special);
				}

				d.count     = int_field (e, "count");
				d.min_words = int_field (e, "min_words");
				defs.add (d);
			}
		}

		private void load_categories (YYJson.Value? arr) {
			if (arr != null) {
				for (size_t i = 0; i < arr.arr_size (); i++) {
					unowned var e = arr.arr_get (i);
					unowned var id_v = e.obj_get ("id");
					if (id_v == null)
						continue;
					var c = new Category ();
					c.id    = id_v.get_str ();
					c.icon  = str_field (e, "icon");
					c.label = str_field (e, "label");
					if (c.label == "")
						c.label = c.id;
					cats.add (c);
				}
			}
			foreach (unowned Def d in defs.data) {
				if (d.cat == "" || has_cat (d.cat))
					continue;
				var c = new Category ();
				c.id    = d.cat;
				c.label = d.cat;
				cats.add (c);
			}
		}

		private bool has_cat (string id) {
			foreach (unowned Category c in cats.data)
				if (c.id == id)
					return true;
			return false;
		}

		private int64 special_arg (YYJson.Value e, string special) {
			string key;
			switch (special) {
			case "session":           key = "seconds"; break;
			case "streak":            key = "days";    break;
			case "same_hour_streak":  key = "days";    break;
			case "session_lsp_count": key = "count";   break;
			case "distinct_days":     key = "days";    break;
			case "distinct_langs":    key = "langs";   break;
			case "ratio":             key = "ratio";   break;
			case "write_rate":        key = "window";  break;
			case "theme_session":     key = "count";   break;
			case "lsp_count":         key = "count";   break;
			default:                  return 0;
			}
			return int_field (e, key);
		}

		private static string str_field (YYJson.Value e, string key) {
			unowned var v = e.obj_get (key);
			return v != null ? v.get_str () : "";
		}

		private static int64 int_field (YYJson.Value e, string key) {
			unowned var v = e.obj_get (key);
			return v != null ? v.get_sint () : 0;
		}

		private static bool bool_field (YYJson.Value e, string key) {
			unowned var v = e.obj_get (key);
			return v != null && v.get_bool ();
		}
	}

	public class State : Object {

		private string path;
		private string history_path;

		private HashTable<string, int64?> counters = new HashTable<string, int64?> (str_hash, str_equal);
		private HashTable<string, HashTable<string, int64?>> history =
			new HashTable<string, HashTable<string, int64?>> (str_hash, str_equal);
		private HashTable<string, string> unlocked  = new HashTable<string, string> (str_hash, str_equal);
		private HashTable<string, bool>   langs     = new HashTable<string, bool> (str_hash, str_equal);
		private HashTable<string, bool>   lsp_ready = new HashTable<string, bool> (str_hash, str_equal);

		private HashTable<string, int64?> today_bucket = new HashTable<string, int64?> (str_hash, str_equal);
		private string today_date = "";

		public string last_day      { get; set; default = ""; }
		public int64  streak        { get; set; default = 0; }
		public int64  best_streak   { get; set; default = 0; }
		public bool   dirty         { get; set; default = false; }
		public bool   history_dirty { get; set; default = false; }

		public int64 distinct_days {
			get { return (int64) history.size () + (today_bucket.size () > 0 ? 1 : 0); }
		}

		public uint langs_count     { get { return langs.size (); } }
		public uint lsp_ready_count { get { return lsp_ready.size (); } }
		public uint unlocked_count  { get { return unlocked.size (); } }

		public static string default_path () {
			return Path.build_filename (
				Environment.get_user_config_dir (), "supravim", "achievements.json");
		}

		public State (string? state_path = null) {
			path = state_path ?? default_path ();
			history_path = Path.build_filename (
				Path.get_dirname (path), "achievements_history.json");
			load ();
		}

		public static string today () {
			return new DateTime.now_local ().format ("%Y-%m-%d");
		}

		public static string yesterday () {
			return new DateTime.now_local ().add_days (-1).format ("%Y-%m-%d");
		}

		public int64 counter (string key) {
			return counters[key] ?? 0;
		}

		public int64 today_value (string key) {
			return today_bucket[key] ?? 0;
		}

		private unowned HashTable<string, int64?>? bucket_of (string date) {
			if (date == today_date)
				return today_bucket;
			return history[date];
		}

		public int64 day_value (string date, string key) {
			unowned var bucket = bucket_of (date);
			if (bucket == null)
				return 0;
			return bucket[key] ?? 0;
		}

		public bool has_day (string date, string key) {
			unowned var bucket = bucket_of (date);
			return bucket != null && bucket[key] != null;
		}

		public int64 total_of (string key) {
			int64 sum = today_bucket[key] ?? 0;
			history.foreach ((date, bucket) => {
				sum += bucket[key] ?? 0;
			});
			return sum;
		}

		public HashTable<string, int64?> breakdown (string prefix) {
			var res = new HashTable<string, int64?> (str_hash, str_equal);
			accumulate_prefix (today_bucket, prefix, res);
			history.foreach ((date, bucket) => accumulate_prefix (bucket, prefix, res));
			return res;
		}

		public HashTable<string, int64?> breakdown_days (string prefix, int days) {
			var res = new HashTable<string, int64?> (str_hash, str_equal);
			var d = new DateTime.now_local ();
			for (int i = 0; i < days; i++) {
				string ds = d.add_days (-i).format ("%Y-%m-%d");
				unowned var bucket = bucket_of (ds);
				if (bucket != null)
					accumulate_prefix (bucket, prefix, res);
			}
			return res;
		}

		private static void accumulate_prefix (HashTable<string, int64?> bucket,
			string prefix, HashTable<string, int64?> res) {
			bucket.foreach ((k, v) => {
				if (k.has_prefix (prefix)) {
					string name = k.substring (prefix.length);
					res[name] = (res[name] ?? 0) + v;
				}
			});
		}

		public void add (string key, int64 delta, bool is_max = false) {
			ensure_today ();
			if (is_max) {
				counters[key]      = int64.max (counter (key), delta);
				today_bucket[key]  = int64.max (today_value (key), delta);
			} else {
				counters[key]      = counter (key) + delta;
				today_bucket[key]  = today_value (key) + delta;
			}
			dirty = true;
		}

		public void add_today (string key, int64 delta) {
			ensure_today ();
			today_bucket[key] = today_value (key) + delta;
			dirty = true;
		}

		public void set_today (string key, int64 value) {
			ensure_today ();
			today_bucket[key] = value;
			dirty = true;
		}

		public bool has_today (string key) {
			return today_bucket[key] != null;
		}

		public bool is_unlocked (string id) {
			return id in unlocked;
		}

		public string? unlocked_at (string id) {
			return unlocked[id];
		}

		public void unlock (string id) {
			if (id in unlocked)
				return;
			unlocked[id] = today ();
			dirty = true;
		}

		public bool add_lang (string ft) {
			if (ft == "" || ft in langs)
				return false;
			langs[ft] = true;
			dirty = true;
			return true;
		}

		public bool add_lsp_ready (string name) {
			if (name == "" || name in lsp_ready)
				return false;
			lsp_ready[name] = true;
			dirty = true;
			return true;
		}

		public void ensure_today () {
			string t = today ();
			if (today_date == t)
				return;
			if (today_date != "" && today_bucket.size () > 0) {
				history[today_date] = (owned) today_bucket;
				today_bucket = new HashTable<string, int64?> (str_hash, str_equal);
				history_dirty = true;
			}
			today_date = t;
			dirty = true;
		}

		public void roll_day () {
			ensure_today ();
			if (last_day == today_date)
				return;
			if (last_day == "")
				streak = 1;
			else if (last_day == yesterday ())
				streak += 1;
			else
				streak = 1;
			last_day = today_date;
			if (streak > best_streak)
				best_streak = streak;
			dirty = true;
		}

		public void load () {
			today_date = today ();

			if (FileUtils.test (path, FileTest.EXISTS)) {
				string data;
				try { FileUtils.get_contents (path, out data); }
				catch (Error e) { warning ("achievements: read '%s' failed: %s", path, e.message); data = ""; }

				var doc = YYJson.Doc.read (data, data.length);
				unowned var root = doc != null ? doc.get_root () : null;
				if (root != null) {
					read_int_map (root.obj_get ("counters"), counters);
					read_str_map (root.obj_get ("unlocked"), unlocked);
					read_str_set (root.obj_get ("langs"), langs);
					read_str_set (root.obj_get ("lsp_ready"), lsp_ready);
					read_meta (root.obj_get ("meta"));

					unowned var daily = root.obj_get ("daily");
					if (daily != null) {
						unowned var date_v = daily.obj_get ("date");
						if (date_v != null)
							today_date = date_v.get_str ();
						read_int_map (daily.obj_get ("values"), today_bucket);
					}

					unowned var old_hist = root.obj_get ("history");
					if (old_hist != null) {
						read_history (old_hist);
						dirty = true;
						history_dirty = true;
					}
				}
			}

			if (FileUtils.test (history_path, FileTest.EXISTS)) {
				string hdata;
				try { FileUtils.get_contents (history_path, out hdata); }
				catch (Error e) { warning ("achievements: read '%s' failed: %s", history_path, e.message); hdata = ""; }
				var hdoc = YYJson.Doc.read (hdata, hdata.length);
				if (hdoc != null && hdoc.get_root () != null)
					read_history (hdoc.get_root ());
			}

			unowned var dup = history[today_date];
			if (dup != null) {
				if (today_bucket.size () == 0)
					dup.foreach ((k, v) => today_bucket[k] = v);
				history.remove (today_date);
			}
		}

		private void read_history (YYJson.Value obj) {
			YYJson.ObjIter it;
			if (!YYJson.ObjIter.init (obj, out it))
				return;
			unowned YYJson.Value? key;
			while ((key = it.next ()) != null) {
				var bucket = new HashTable<string, int64?> (str_hash, str_equal);
				read_int_map (YYJson.ObjIter.get_val (key), bucket);
				history[key.get_str ()] = (owned) bucket;
			}
		}

		private void read_meta (YYJson.Value? meta) {
			if (meta == null)
				return;
			unowned var last_v   = meta.obj_get ("last_day");
			unowned var streak_v = meta.obj_get ("streak");
			unowned var best_v   = meta.obj_get ("best_streak");
			if (last_v   != null) last_day    = last_v.get_str ();
			if (streak_v != null) streak      = streak_v.get_sint ();
			if (best_v   != null) best_streak = best_v.get_sint ();
		}

		public void save () {
			dirty = false;
			DirUtils.create_with_parents (Path.get_dirname (path), 0755);

			var doc = new YYJson.MutDoc ();
			unowned var root = doc.obj ();
			doc.set_root (root);

			root.obj_add_val (doc, "counters",  int_map_obj (doc, counters));
			root.obj_add_val (doc, "unlocked",  str_map_obj (doc, unlocked));
			root.obj_add_val (doc, "langs",     str_set_arr (doc, langs));
			root.obj_add_val (doc, "lsp_ready", str_set_arr (doc, lsp_ready));

			unowned var daily = doc.obj ();
			daily.obj_add_str (doc, "date", today_date);
			daily.obj_add_val (doc, "values", int_map_obj (doc, today_bucket));
			root.obj_add_val (doc, "daily", daily);

			unowned var meta = doc.obj ();
			meta.obj_add_str (doc, "last_day", last_day);
			meta.obj_add_int (doc, "streak", streak);
			meta.obj_add_int (doc, "best_streak", best_streak);
			meta.obj_add_int (doc, "distinct_days", distinct_days);
			root.obj_add_val (doc, "meta", meta);

			string? json = doc.write (YYJson.WRITE_PRETTY);
			if (json != null) {
				try { FileUtils.set_contents (path, json); }
				catch (Error e) { warning ("achievements: save '%s' failed: %s", path, e.message); }
			}

			if (history_dirty)
				save_history ();
		}

		private void save_history () {
			var doc = new YYJson.MutDoc ();
			unowned var root = doc.obj ();
			doc.set_root (root);
			history.foreach ((date, bucket) => {
				root.obj_add_val (doc, date, int_map_obj (doc, bucket));
			});
			string? json = doc.write (YYJson.WRITE_PRETTY);
			if (json == null)
				return;
			try {
				FileUtils.set_contents (history_path, json);
				history_dirty = false;
			} catch (Error e) { warning ("achievements: save '%s' failed: %s", history_path, e.message); }
		}

		private static void read_int_map (YYJson.Value? obj, HashTable<string, int64?> dest) {
			if (obj == null)
				return;
			YYJson.ObjIter it;
			if (!YYJson.ObjIter.init (obj, out it))
				return;
			unowned YYJson.Value? key;
			while ((key = it.next ()) != null) {
				unowned var v = YYJson.ObjIter.get_val (key);
				if (v != null)
					dest[key.get_str ()] = v.get_sint ();
			}
		}

		private static void read_str_map (YYJson.Value? obj, HashTable<string, string> dest) {
			if (obj == null)
				return;
			YYJson.ObjIter it;
			if (!YYJson.ObjIter.init (obj, out it))
				return;
			unowned YYJson.Value? key;
			while ((key = it.next ()) != null) {
				unowned var v = YYJson.ObjIter.get_val (key);
				if (v != null)
					dest[key.get_str ()] = v.get_str ();
			}
		}

		private static void read_str_set (YYJson.Value? arr, HashTable<string, bool> dest) {
			if (arr == null)
				return;
			for (size_t i = 0; i < arr.arr_size (); i++) {
				unowned var v = arr.arr_get (i);
				if (v != null)
					dest[v.get_str ()] = true;
			}
		}

		private static unowned YYJson.MutValue int_map_obj (YYJson.MutDoc doc, HashTable<string, int64?> src) {
			unowned var o = doc.obj ();
			src.foreach ((k, v) => o.obj_add_int (doc, k, v));
			return o;
		}

		private static unowned YYJson.MutValue str_map_obj (YYJson.MutDoc doc, HashTable<string, string> src) {
			unowned var o = doc.obj ();
			src.foreach ((k, v) => o.obj_add_str (doc, k, v));
			return o;
		}

		private static unowned YYJson.MutValue str_set_arr (YYJson.MutDoc doc, HashTable<string, bool> src) {
			unowned var a = doc.arr ();
			src.foreach ((k, v) => a.arr_add_str (doc, k));
			return a;
		}
	}
}
