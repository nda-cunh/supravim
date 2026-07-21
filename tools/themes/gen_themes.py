#!/usr/bin/env python3
"""Generate site/themes.html from the parsed colorschemes.

Regenerate with:  python3 gen_themes.py > ../../site/themes.html
"""
import json
import re
from pathlib import Path

HERE = Path(__file__).parent
THEMES = json.loads((HERE / "themes.json").read_text())

DISPLAY = {
    "atom": "Atom",
    "catppuccin_frappe": "Catppuccin Frappé",
    "catppuccin_latte": "Catppuccin Latte",
    "catppuccin_macchiato": "Catppuccin Macchiato",
    "catppuccin_mocha": "Catppuccin Mocha",
    "dracula": "Dracula",
    "gruvbox": "Gruvbox",
    "iceberg": "Iceberg",
    "kyotonight": "Kyoto Night",
    "onedark": "One Dark",
    "rosepine": "Rosé Pine",
    "rosepine_dawn": "Rosé Pine Dawn",
    "rosepine_moon": "Rosé Pine Moon",
    "supracool": "SupraCool",
    "supradark": "SupraDark",
    "supradeep": "SupraDeep",
    "supraevening": "SupraEvening",
    "supralight": "SupraLight",
    "supraonedark": "SupraOneDark",
    "suprawarm": "SupraWarm",
    "suprawarmer": "SupraWarmer",
    "tokyonight": "Tokyo Night",
    "tokyostorm": "Tokyo Storm",
    "vscode": "VS Code",
}

DEFAULT = "supradeep"

# The same Vala buffer rendered in all 24 schemes — SupraVim's own language, and
# the only fair way to compare: identical tokens, only the colours change.
# (c comment, k keyword, t type, f function, s string, n number, p punctuation)
CODE = [
    [("c", "// resolve a plugin from the store")],
    [("k", "public "), ("t", "Plugin? "), ("f", "find "), ("p", "("), ("t", "string "), ("x", "name"), ("p", ") {")],
    [("p", "  "), ("k", "var "), ("x", "tried "), ("p", "= "), ("n", "0"), ("p", ";")],
    [("p", "  "), ("k", "foreach "), ("p", "("), ("k", "var "), ("x", "p "), ("k", "in "), ("x", "plugins"), ("p", ") {")],
    [("p", "    "), ("x", "tried"), ("p", "++;")],
    [("p", "    "), ("k", "if "), ("p", "("), ("x", "p"), ("p", "."), ("x", "name "), ("p", "== "), ("x", "name"), ("p", ")")],
    [("p", "      "), ("k", "return "), ("x", "p"), ("p", ";")],
    [("p", "  }")],
    [("p", "  "), ("f", "print "), ("p", "("), ("s", '"missed %d\\n"'), ("p", ", "), ("x", "tried"), ("p", ");")],
    [("p", "  "), ("k", "return "), ("v", "null"), ("p", ";")],
    [("p", "}")],
]

# token class -> which parsed colour drives it
TOKEN_VAR = {
    "c": "--t-comment",
    "k": "--t-kw",
    "t": "--t-type",
    "f": "--t-fn",
    "s": "--t-str",
    "n": "--t-num",
    "v": "--t-const",
    "x": "--t-fg",
    "p": "--t-fg",
}


def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def mix(hex_a, hex_b, t):
    """blend two hex colours, t in [0,1] toward b"""
    a = [int(hex_a[i:i + 2], 16) for i in (1, 3, 5)]
    b = [int(hex_b[i:i + 2], 16) for i in (1, 3, 5)]
    return "#%02x%02x%02x" % tuple(round(a[i] + (b[i] - a[i]) * t) for i in range(3))


def code_html():
    out = []
    for i, line in enumerate(CODE, 1):
        spans = "".join(
            f'<span class="{cls}">{esc(txt)}</span>' if cls != "p" else esc(txt)
            for cls, txt in line
        )
        out.append(f'<span class="ln">{i:>2}</span>{spans}')
    return "\n".join(out)


CODE_HTML = code_html()


def card(t):
    name = t["name"]
    disp = DISPLAY.get(name, name)
    bg, fg = t["bg"], t["fg"]
    light = t["light"]

    # a scheme may leave the statusline unstyled; derive something honest from
    # its own background rather than inventing a colour
    statusbg = t.get("statusbg") or mix(bg, fg, .18)
    statusfg = t.get("statusfg") or fg
    gutter = t.get("linenr") or mix(bg, fg, .45)

    swatches = [t["keyword"], t["func"], t["type"], t["string"], t["num"] if "num" in t else t["number"], t["comment"]]
    sw = "".join(f'<i style="background:{c}"></i>' for c in swatches if c)

    style = "; ".join([
        f"--t-bg:{bg}",
        f"--t-fg:{fg}",
        f"--t-comment:{t['comment']}",
        f"--t-str:{t['string']}",
        f"--t-num:{t['number']}",
        f"--t-kw:{t['keyword']}",
        f"--t-fn:{t['func']}",
        f"--t-type:{t['type']}",
        f"--t-const:{t['const']}",
        f"--t-ln:{gutter}",
        f"--t-sbg:{statusbg}",
        f"--t-sfg:{statusfg}",
    ])

    badge = '<span class="tag default">default</span>' if name == DEFAULT else ""
    mode = "light" if light else "dark"

    return f'''<button type="button" class="card" data-name="{name}" data-mode="{mode}" data-disp="{esc(disp)}" style="{style}">
  <div class="win">
    <div class="bar"><span class="file">Plugin.vala</span><span class="sw">{sw}</span></div>
    <pre class="code">{CODE_HTML}</pre>
    <div class="status"><span>NORMAL</span><span>{esc(disp)}</span></div>
  </div>
  <div class="meta">
    <span class="nm">{esc(disp)}</span>{badge}
    <code class="cs">{name}</code>
  </div>
</button>'''


def main():
    supra = [t for t in THEMES if t["name"].startswith("supra")]
    ports = [t for t in THEMES if not t["name"].startswith("supra")]
    n_light = sum(1 for t in THEMES if t["light"])
    n_dark = len(THEMES) - n_light

    tpl = (HERE / "themes_template.html").read_text()
    out = (tpl
           .replace("{{TOTAL}}", str(len(THEMES)))
           .replace("{{NDARK}}", str(n_dark))
           .replace("{{NLIGHT}}", str(n_light))
           .replace("{{NSUPRA}}", str(len(supra)))
           .replace("{{NPORTS}}", str(len(ports)))
           .replace("{{CARDS_SUPRA}}", "\n".join(card(t) for t in supra))
           .replace("{{CARDS_PORTS}}", "\n".join(card(t) for t in ports)))
    print(out)


main()
