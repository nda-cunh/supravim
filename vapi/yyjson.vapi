[CCode (cheader_filename = "yyjson.h")]
namespace YYJson {

    [CCode (cname = "yyjson_type", cprefix = "YYJSON_TYPE_")]
    public enum Type {
        NONE, ANY, NULL, BOOL, NUM, STR, ARR, OBJ
    }

	[CCode (cname = "yyjson_subtype", cprefix = "YYJSON_SUBTYPE_")]
    public enum SubType {
        NONE, NO_SUBTYPE, UINT, SINT, REAL, TRUE, FALSE
    }

	[CCode (cname = "yyjson_doc", free_function = "yyjson_doc_free")]
    [Compact]
    public class Doc {
        [CCode (cname = "yyjson_read")]
        public static Doc? read (string dat, size_t len, uint flg = 0);
        
        [CCode (cname = "yyjson_doc_get_root")]
        public unowned Value get_root();

        [CCode (cname = "yyjson_doc_get_val_count")]
        public size_t get_val_count();
    }

    [CCode (cname = "yyjson_val")]
    [Compact]
    public class Value {
        [CCode (cname = "yyjson_get_type")]
        public Type get_type();

        [CCode (cname = "yyjson_get_subtype")]
        public SubType get_subtype();

        [CCode (cname = "yyjson_get_str")]
        public unowned string? get_str();

        [CCode (cname = "yyjson_get_int")]
        public int get_int();

        [CCode (cname = "yyjson_get_uint")]
        public uint64 get_uint();

        [CCode (cname = "yyjson_get_bool")]
        public bool get_bool();

        [CCode (cname = "yyjson_get_double")]
        public double get_double();

        [CCode (cname = "yyjson_obj_get")]
        public unowned Value? obj_get(string key);

        [CCode (cname = "yyjson_obj_size")]
        public size_t obj_size();

        [CCode (cname = "yyjson_arr_get")]
        public unowned Value? arr_get(size_t idx);

        [CCode (cname = "yyjson_arr_size")]
        public size_t arr_size();
    }

    [CCode (cname = "yyjson_mut_doc", free_function = "yyjson_mut_doc_free")]
    [Compact]
    public class MutDoc {
        [CCode (cname = "yyjson_mut_doc_new")]
        public MutDoc (void* alc = null);
        [CCode (cname = "yyjson_mut_obj")]
        public unowned MutValue obj();
        [CCode (cname = "yyjson_mut_arr")]
        public unowned MutValue arr();
        [CCode (cname = "yyjson_mut_doc_set_root")]
        public void set_root(MutValue root);
        [CCode (cname = "yyjson_mut_write")]
        public string? write(uint flg = 0, size_t* len = null);
    }

    [CCode (cname = "yyjson_mut_val")]
    [Compact]
    public class MutValue {
        /* On force l'ordre C: (doc, val, ...) en mettant 'instance_pos = 2' */
        
        [CCode (cname = "yyjson_mut_obj_add_strcpy", instance_pos = 1.1)]
        public bool obj_add_str(MutDoc doc, string key, string val);

        [CCode (cname = "yyjson_mut_obj_add_int", instance_pos = 1.1)]
        public bool obj_add_int(MutDoc doc, string key, int64 val);

        [CCode (cname = "yyjson_mut_obj_put", instance_pos = -1)]
        public bool obj_put(string key, MutValue val);

        [CCode (cname = "yyjson_mut_obj_add_bool", instance_pos = 1.1)]
        public bool obj_add_bool(MutDoc doc, string key, bool val);

        // Creates a nested array, adds it to the object, and returns it
        [CCode (cname = "yyjson_mut_obj_add_arr", instance_pos = 1.1)]
        public unowned MutValue? obj_add_arr(MutDoc doc, string key);

        [CCode (cname = "yyjson_mut_arr_add_strcpy", instance_pos = 1.1)]
        public bool arr_add_str(MutDoc doc, string val);

        // Creates a nested object, appends it to the array, and returns it
        [CCode (cname = "yyjson_mut_arr_add_obj", instance_pos = 1.1)]
        public unowned MutValue? arr_add_obj(MutDoc doc);

		[CCode (cname = "yyjson_mut_arr_add_val")]
		public bool arr_add_val(MutValue val);
	}

    [CCode (cname = "yyjson_obj_iter", has_type_id = false)]
    public struct ObjIter {
        [CCode (cname = "yyjson_obj_iter_init")]
        public static bool init (Value obj, out ObjIter iter);

        [CCode (cname = "yyjson_obj_iter_next")]
        public unowned Value? next ();

        [CCode (cname = "yyjson_obj_iter_get_val")]
        public static unowned Value? get_val (Value key);
    }

    /* Supprimer les '= 1' car ce sont des constantes externes */
    [CCode (cname = "YYJSON_WRITE_PRETTY")]
    public const uint WRITE_PRETTY;
}
