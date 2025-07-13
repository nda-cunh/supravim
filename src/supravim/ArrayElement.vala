public class ArrayElements {
	public void append (Element element) {
		elements += element;
	}

	private int get_score (Element element) {
		if (element.value == "true" || element.value == "false")
			return 0;
		else
			return -1;
	}

	public ArrayElements sort (Compare cmp_func) {
		for (int i = 0; i < elements.length - 1; i++) {
			for (int j = i + 1; j < elements.length; j++) {
				if (cmp_func (elements[i], elements[j]) > 0) {
					unowned var temp = elements[i];
					elements[i] = elements[j];
					elements[j] = temp;
				}
			}
		}
		return this;

	}

	public ArrayElements filter (Filter filter_func) {
		var result = new ArrayElements ();
		foreach (Element element in elements) {
			if (filter_func (element)) {
				result.append (element);
			}
		}
		return result;
	}

	public ArrayElements get_general () {
		return this
			.filter ((a) => (a.file == rc_path))
			.sort ((a, b) => get_score (b) - get_score (a));
	}

	public ArrayElements get_plugins () {
		return this
			.filter ((a) => (a.file != rc_path))
			.sort ((a, b) => get_score (b) - get_score (a));
	}

	public unowned Element? find (string name) {
		foreach (unowned Element element in elements) {
			if (element.name == name) {
				return element;
			}
		}
		return null;
	}

	public unowned Element get (int index) {
		return elements[index];
	}

	public uint size {
		get {return elements.length;}
	}

	public delegate int Compare (Element a, Element b);
	public delegate bool Filter (Element a);
	private Element []elements = {};

}
