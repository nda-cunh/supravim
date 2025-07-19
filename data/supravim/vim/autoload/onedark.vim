vim9script

var overrides = get(g:, "onedark_color_overrides", {})

var colors = {
	red: get(overrides, "red", { "gui": "#E06C75", "cterm": "204", "cterm16": "1" }),
	dark_red: get(overrides, "dark_red", { "gui": "#BE5046", "cterm": "196", "cterm16": "9" }),
	green: get(overrides, "green", { "gui": "#98C379", "cterm": "114", "cterm16": "2" }),
	yellow: get(overrides, "yellow", { "gui": "#E5C07B", "cterm": "180", "cterm16": "3" }),
	dark_yellow: get(overrides, "dark_yellow", { "gui": "#D19A66", "cterm": "173", "cterm16": "11" }),
	blue: get(overrides, "blue", { "gui": "#61AFEF", "cterm": "39", "cterm16": "4" }),
	purple: get(overrides, "purple", { "gui": "#C678DD", "cterm": "170", "cterm16": "5" }),
	cyan: get(overrides, "cyan", { "gui": "#56B6C2", "cterm": "38", "cterm16": "6" }),
	white: get(overrides, "white", { "gui": "#ABB2BF", "cterm": "145", "cterm16": "15" }),
	black: get(overrides, "black", { "gui": "#282C34", "cterm": "235", "cterm16": "0" }),
	foreground: get(overrides, "foreground", { "gui": "#ABB2BF", "cterm": "145", "cterm16": "NONE" }),
	background: get(overrides, "background", { "gui": "#282C34", "cterm": "235", "cterm16": "NONE" }),
	comment_grey: get(overrides, "comment_grey", { "gui": "#5C6370", "cterm": "59", "cterm16": "7" }),
	gutter_fg_grey: get(overrides, "gutter_fg_grey", { "gui": "#4B5263", "cterm": "238", "cterm16": "8" }),
	cursor_grey: get(overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "0" }),
	visual_grey: get(overrides, "visual_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
	menu_grey: get(overrides, "menu_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "7" }),
	special_grey: get(overrides, "special_grey", { "gui": "#3B4048", "cterm": "238", "cterm16": "7" }),
	vertsplit: get(overrides, "vertsplit", { "gui": "#3E4452", "cterm": "59", "cterm16": "7" }),
}

export def GetColors(): dict<any>
	return colors
enddef
