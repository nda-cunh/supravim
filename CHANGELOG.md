# 📜 CHANGELOG — Supravim 6.0

## 🚀 Major New Features
- **Extended Multi-Language Support**  
  Full support for many additional languages, including:
  - TypeScript
  - JavaScript
  - JSON
  - Java  
  … and many more.

<img src="readme_img/vala-support.git">

- **SupraWater — Integrated File Manager**  
  A new graphical file manager that allows you to:
  - Create, rename, copy, paste, and delete files.
  - Open files directly in their appropriate application (e.g., an image opens in an image viewer, an executable runs in the terminal).

<img src="readme_img/suprawater.gif">

- **SupraTree — Tree View**  
  A tree-structured version of SupraWater to easily navigate your project files.

<img src="readme_img/supratree.png">

- **SupraSearch — Advanced Graphical Search**  
  A full-featured search-and-replace interface with real-time results and full **regular expression** support.

<img src="readme_img/suprasearch.gif">

- **FuzzyClip — Clipboard History Manager**  
  Accessible via @<space> c@ to easily find all your previous clipboard entries.

<img src="readme_img/fuzzyclip.png">

---

## 🎯 Key Shortcut Changes
- **Terminal**: @Shift+T@ → @Ctrl+T@
- **AutoNorme**: @Ctrl+D@ → @<space> v@
- **Enable AutoNorme**: @F2@ → @<space> F2@
- **Disable Norminette**: @F3@ → @<space> F3@
- **LSP / Quick Rename**: @F2@

---

## 🛠 New Options
- **Autoclose** (automatic closing of paired characters):
  - `autoclose_quotes` : `"` `'` `` ` ``
  - `autoclose_brackets` : `(` `)` et `[` `]`
  - `autoclose_braces` : `{` `}`
  - `autoclose_angle` : `<` `>`

  Also works in **visual selection**:  
  Example: select some text, then type @(@ → the selection will be automatically surrounded with @(...)@.

- **symbol_signs**: Customize error symbols in the @signcolumn@.

- Enable/Disable via:

```bash
  supravim -e   # Enable
  supravim -d   # Disable
```

## 🎨 Improvements

- Optimized and better integrated themes for faster startup and a more consistent look.

<img src="readme_img/fuzzyclip.png">
