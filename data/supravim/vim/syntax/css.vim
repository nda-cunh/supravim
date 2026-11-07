vim9script

var keepre = &regexpengine
&regexpengine = 1

# Vim syntax file
# Language:     Cascading Style Sheets
# Previous Contributor List:
#               Jules Wang      <w.jq0722@gmail.com>
#               Claudio Fleiner <claudio@fleiner.com>
#               Yeti            (Add full CSS2, HTML4 support)
#               Nikolai Weibull (Add CSS2 support)
# URL:          https://github.com/vim-language-dept/css-syntax.vim
# Maintainer:   Jay Sitter <jay@jaysitter.com>
# Last Change:  2024 Mar 2
# Changelog:
# 2025 Nov 11: improve support for cssBoxProperties #18717
# 2026 Feb 13: add missing numeric units (baseline 2015, 2020, 2022, 2023, 2026) #19325

# quit when a syntax file was already loaded
if !exists("g:main_syntax")
  if exists("b:current_syntax")
    &regexpengine = keepre
    finish
  endif
  g:main_syntax = 'css'
elseif exists("b:current_syntax") && b:current_syntax == "css"
  &regexpengine = keepre
  finish
endif


syn case ignore
# Add dash to allowed keyword characters.
syn iskeyword @,48-57,_,192-255,-

# HTML4 tags
syn keyword cssTagName abbr address area a b base
syn keyword cssTagName bdo blockquote body br button
syn keyword cssTagName caption cite code col colgroup dd del
syn keyword cssTagName dfn div dl dt em fieldset form
syn keyword cssTagName h1 h2 h3 h4 h5 h6 head hr html img i
syn keyword cssTagName iframe input ins isindex kbd label legend li
syn keyword cssTagName link map menu meta noscript ol optgroup
syn keyword cssTagName option p param picture pre q s samp script small
syn keyword cssTagName span strong sub sup tbody td
syn keyword cssTagName textarea tfoot th thead title tr ul u var
syn keyword cssTagName object svg
syn keyword cssTagName path circle rect line polygon polyline ellipse tspan defs use
syn keyword cssTagName select style table

# 34 HTML5 tags
syn keyword cssTagName article aside audio bdi canvas command data
syn keyword cssTagName datalist details dialog embed figcaption figure footer
syn keyword cssTagName header hgroup keygen main mark menuitem meter nav
syn keyword cssTagName output progress rt rp ruby section
syn keyword cssTagName source summary time track video wbr

# Tags not supported in HTML5
# acronym applet basefont big center dir
# font frame frameset noframes strike tt

syn match cssTagName "\*"

# selectors
syn match cssSelectorOp "[,>+~]"
syn match cssSelectorOp2 "[~|^$*]\?=" contained
syn region cssAttributeSelector matchgroup=cssSelectorOp start="\[" end="]" contains=cssUnicodeEscape,cssSelectorOp2,cssStringQ,cssStringQQ

# .class and #id
syn match cssClassName "\.-\=[A-Za-z_][A-Za-z0-9_-]*" contains=cssClassNameDot
syn match cssClassNameDot contained '\.'

try
syn match cssIdentifier "#[A-Za-zÀ-ÿ_@][A-Za-zÀ-ÿ0-9_@-]*"
catch /^.*/
syn match cssIdentifier "#[A-Za-z_@][A-Za-z0-9_@-]*"
endtry

# digits
syn match cssValueInteger contained "[-+]\=\d\+"
syn match cssValueNumber contained "[-+]\=\d\+\%(\.\d*\)\="
syn match cssValueLength contained "[-+]\=\d\+\%(\.\d*\)\=\%(mm\|cm\|in\|pt\|pc\|px\|dpi\|dppx\|dpcm\|fr\|Q\|x\)\>"
syn match cssValueLength contained "[-+]\=\d\+\%(\.\d*\)\=r\=\%(em\|ex\|cap\|lh\|ch\|ic\)\>"
syn match cssValueLength contained "[-+]\=\d\+\%(\.\d*\)\=[dls]\=\%(vb\|vh\|vi\|vmax\|vmin\|vw\)\>"
syn match cssValueLength contained "[-+]\=\d\+\%(\.\d*\)\=%"
syn match cssValueAngle contained "[-+]\=\d\+\%(\.\d*\)\=\%(deg\|grad\|rad\|turn\)\>"
syn match cssValueTime contained "+\=\d\+\%(\.\d*\)\=\%(ms\|s\)\>"
syn match cssValueFrequency contained "+\=\d\+\%(\.\d*\)\=\%(Hz\|kHz\)\>"

# The 16 basic color names
syn keyword cssColor contained aqua black blue fuchsia gray green lime maroon navy olive purple red silver teal yellow

# 130 more color names
syn keyword cssColor contained aliceblue antiquewhite aquamarine azure
syn keyword cssColor contained beige bisque blanchedalmond blueviolet brown burlywood
syn keyword cssColor contained cadetblue chartreuse chocolate coral cornflowerblue cornsilk crimson cyan
syn keyword cssColor contained darkblue darkcyan darkgoldenrod darkgray darkgreen darkgrey darkkhaki
syn keyword cssColor contained darkmagenta darkolivegreen darkorange darkorchid darkred darksalmon darkseagreen
syn keyword cssColor contained darkslateblue darkslategray darkslategrey
syn keyword cssColor contained darkturquoise darkviolet
syn keyword cssColor contained deeppink deepskyblue dimgray dimgrey dodgerblue firebrick
syn keyword cssColor contained floralwhite forestgreen gainsboro ghostwhite gold
syn keyword cssColor contained goldenrod greenyellow grey honeydew hotpink
syn keyword cssColor contained indianred indigo ivory khaki lavender lavenderblush lawngreen
syn keyword cssColor contained lemonchiffon limegreen linen magenta
syn keyword cssColor contained lightblue lightcoral lightcyan lightgoldenrodyellow lightgray lightgreen
syn keyword cssColor contained lightgrey lightpink lightsalmon lightseagreen lightskyblue lightyellow
syn keyword cssColor contained lightslategray lightslategrey lightsteelblue
syn keyword cssColor contained mediumaquamarine mediumblue mediumorchid mediumpurple mediumseagreen
syn keyword cssColor contained mediumslateblue mediumspringgreen mediumturquoise mediumvioletred
syn keyword cssColor contained midnightblue mintcream mistyrose moccasin navajowhite
syn keyword cssColor contained oldlace olivedrab orange orangered orchid
syn keyword cssColor contained palegoldenrod palegreen paleturquoise palevioletred
syn keyword cssColor contained papayawhip peachpuff peru pink plum powderblue
syn keyword cssColor contained rosybrown royalblue rebeccapurple saddlebrown salmon
syn keyword cssColor contained sandybrown seagreen seashell sienna skyblue slateblue
syn keyword cssColor contained slategray slategrey snow springgreen steelblue tan
syn keyword cssColor contained thistle tomato turquoise violet wheat
syn keyword cssColor contained whitesmoke yellowgreen

# FIXME: These are actually case-insensitive too, but (a) specs recommend using
# mixed-case (b) it's hard to highlight the word `Background' correctly in
# all situations
syn case match
syn keyword cssColor contained ActiveBorder ActiveCaption AppWorkspace ButtonFace ButtonHighlight ButtonShadow ButtonText CaptionText GrayText Highlight HighlightText InactiveBorder InactiveCaption InactiveCaptionText InfoBackground InfoText Menu MenuText Scrollbar ThreeDDarkShadow ThreeDFace ThreeDHighlight ThreeDLightShadow ThreeDShadow Window WindowFrame WindowText Background
syn case ignore

syn match cssImportant contained "!\s*important\>"
syn match cssCustomProp contained "\<--[a-zA-Z0-9-_]*\>"

syn match cssColor contained "\<transparent\>"
syn keyword cssColor contained currentColor
syn keyword cssColor contained white
syn match cssColor contained "#\x\{3,4\}\>"
syn match cssColor contained "#\x\{6\}\>"
syn match cssColor contained "#\x\{8\}\>"

syn region cssURL contained matchgroup=cssFunctionName start="\<\%(uri\|url\|local\|format\)\s*(" end=")" contains=cssStringQ,cssStringQQ oneline
syn region cssMathGroup contained matchgroup=cssMathParens start="(" end=")" containedin=cssFunction,cssMathGroup contains=cssCustomProp,cssValue.*,cssFunction,cssColor,cssStringQ,cssStringQQ oneline
syn region cssFunction contained matchgroup=cssFunctionName start="\<\%(var\|calc\|clamp\|min\|max\|color-mix\|light-dark\|env\|fit-content\|minmax\|repeat\)\s*(" end=")" contains=cssCustomProp,cssValue.*,cssFunction,cssURL,cssColor,cssStringQ,cssStringQQ oneline
syn region cssFunction contained matchgroup=cssFunctionName start="\<\%(rgb\|clip\|attr\|counter\|rect\|cubic-bezier\|steps\)\s*(" end=")" oneline  contains=cssValueInteger,cssValueNumber,cssValueLength,cssFunctionComma
syn region cssFunction contained matchgroup=cssFunctionName start="\<\%(rgba\|hsl\|hsla\|color-stop\|from\|to\)\s*(" end=")" oneline  contains=cssColor,cssValueInteger,cssValueNumber,cssValueLength,cssFunctionComma,cssFunction
syn region cssFunction contained matchgroup=cssFunctionName start="\<\%(linear-\|radial-\|conic-\)\=\gradient\s*(" end=")" oneline  contains=cssColor,cssValueInteger,cssValueNumber,cssValueLength,cssFunction,cssGradientAttr,cssFunctionComma
syn region cssFunction contained matchgroup=cssFunctionName start="\<\%(matrix\%(3d\)\=\|scale\%(3d\|X\|Y\|Z\)\=\|translate\%(3d\|X\|Y\|Z\)\=\|skew\%(X\|Y\)\=\|rotate\%(3d\|X\|Y\|Z\)\=\|perspective\)\s*(" end=")" oneline contains=cssValueInteger,cssValueNumber,cssValueLength,cssValueAngle,cssFunctionComma
syn region cssFunction contained matchgroup=cssFunctionName start="\<\%(blur\|brightness\|contrast\|drop-shadow\|grayscale\|hue-rotate\|invert\|opacity\|saturate\|sepia\)\s*(" end=")" oneline contains=cssValueInteger,cssValueNumber,cssValueLength,cssValueAngle,cssFunctionComma
syn keyword cssGradientAttr contained top bottom left right cover center middle ellipse at
syn match cssFunctionComma contained ","

# Common Prop and Attr
syn keyword cssCommonAttr contained auto none inherit all default normal
syn keyword cssCommonAttr contained top bottom center stretch hidden visible
syn keyword cssCommonAttr contained max-content min-content fit-content
#------------------------------------------------
# CSS Animations
# http://www.w3.org/TR/css3-animations/
syn keyword cssAnimationProp contained animation-delay animation-direction animation-duration animation-fill-mode animation-name animation-play-state animation-timing-function animation-iteration-count animation

# animation-direction attributes
syn keyword cssAnimationAttr contained alternate reverse
syn keyword cssAnimationAttr contained alternate-reverse

# animation-fill-mode attributes
syn keyword cssAnimationAttr contained forwards backwards both

# animation-play-state attributes
syn keyword cssAnimationAttr contained running paused

# animation-iteration-count attributes
syn keyword cssAnimationAttr contained infinite
#------------------------------------------------
#  CSS Backgrounds and Borders Module Level 3
#  http://www.w3.org/TR/css3-background/
syn keyword cssBackgroundProp contained background-attachment background-clip background-color background-image background-origin background-position background-repeat background-size background
# background-attachment attributes
syn keyword cssBackgroundAttr contained scroll fixed local

# background-position attributes
syn keyword cssBackgroundAttr contained left center right top bottom

# background-repeat attributes
syn keyword cssBackgroundAttr contained no-repeat
syn match cssBackgroundAttr contained "\<repeat\%(-[xy]\)\=\>"

# background-size attributes
syn keyword cssBackgroundAttr contained cover contain

syn keyword cssBorderProp contained border-top-width border-top-color border-top-style border-top border-right-width border-right-color border-right-style border-right border-bottom-width border-bottom-color border-bottom-style border-bottom border-left-width border-left-color border-left-style border-left border-width border-color border-style border
syn keyword cssBorderProp contained border-top-left-radius border-top-right-radius border-bottom-left-radius border-bottom-right-radius border-radius
syn keyword cssBorderProp contained border-inline-start-style border-inline-start-width border-inline-start-color border-inline-start border-inline-end-style border-inline-end-width border-inline-end-color border-inline-end border-inline-style border-inline-width border-inline-color border-inline border-block-start-style border-block-start-width border-block-start-color border-block-start border-block-end-style border-block-end-width border-block-end-color border-block-end border-block-style border-block-width border-block-color border-block
syn keyword cssBorderProp contained border-start-start-radius border-start-end-radius border-end-start-radius border-end-end-radius
syn keyword cssBorderProp contained border-image-outset border-image-repeat border-image-slice border-image-source border-image-width border-image
syn keyword cssBorderProp contained box-decoration-break
syn keyword cssBorderProp contained box-shadow

# border-image attributes
syn keyword cssBorderAttr contained stretch round fill

# border-style attributes
syn keyword cssBorderAttr contained dotted dashed solid double groove ridge inset outset

# border-width attributes
syn keyword cssBorderAttr contained thin thick medium

# box-decoration-break attributes
syn keyword cssBorderAttr contained clone slice
#------------------------------------------------

syn keyword cssBoxProp contained padding-top padding-right padding-bottom padding-left padding
syn keyword cssBoxProp contained margin-top margin-right margin-bottom margin-left margin
syn keyword cssBoxProp contained margin-inline-start margin-inline-end margin-inline margin-block-start margin-block-end margin-block margin padding-inline-start padding-inline-end padding-inline padding-block-start padding-block-end padding-block padding
syn keyword cssBoxProp contained overflow-x overflow-y overflow-style overflow
syn keyword cssBoxProp contained rotation-point rotation
syn keyword cssBoxAttr contained visible hidden scroll auto
syn keyword cssBoxAttr contained no-display no-content

syn keyword cssCascadeProp contained all
syn keyword cssCascadeAttr contained initial unset revert

syn keyword cssColorProp contained opacity
syn keyword cssColorProp contained color-profile
syn keyword cssColorProp contained rendering-intent


syn keyword cssDimensionProp contained min-width min-height max-width max-height
syn keyword cssDimensionProp contained height
syn keyword cssDimensionProp contained width

# CSS Flexible Box Layout Module Level 1
# http://www.w3.org/TR/css3-flexbox/
# CSS Box Alignment Module Level 3
# http://www.w3.org/TR/css-align-3/
syn keyword cssFlexibleBoxProp contained flex-direction flex-wrap flex-flow flex-grow flex-shrink flex-basis flex
syn keyword cssFlexibleBoxProp contained align-items align-self align-content align justify-items justify-self justify-content justify
syn keyword cssFlexibleBoxProp contained order

syn keyword cssFlexibleBoxAttr contained row-reverse row column-reverse column wrap-reverse wrap
syn keyword cssFlexibleBoxAttr contained nowrap stretch baseline center
syn keyword cssFlexibleBoxAttr contained flex-start flex-end flex
syn keyword cssFlexibleBoxAttr contained space-between space-around space-evenly space

# CSS Fonts Module Level 3
# http://www.w3.org/TR/css-fonts-3/
syn keyword cssFontProp contained font-display font-family font-feature-settings font-kerning font-language-override font-size-adjust font-size font-stretch font-style font-synthesis font-variant-alternates font-variant-caps font-variant-east-asian font-variant-ligatures font-variant-numeric font-variant-position font-variant font-weight font

# font attributes
syn keyword cssFontAttr contained icon menu caption
syn keyword cssFontAttr contained message-box
syn keyword cssFontAttr contained status-bar
syn keyword cssFontAttr contained larger smaller
syn match cssFontAttr contained "\<\%(x\{1,2\}-\)\=\%(large\|small\)\>"
syn keyword cssFontAttr contained small-caps small-caption
# font-family attributes
syn keyword cssFontAttr contained sans-serif serif cursive fantasy monospace
# font-feature-settings attributes
syn keyword cssFontAttr contained on off
# font-stretch attributes
syn keyword cssFontAttr contained ultra-condensed ultra-expanded extra-condensed extra-expanded semi-condensed semi-expanded condensed expanded
# font-style attributes
syn keyword cssFontAttr contained italic oblique
# font-synthesis attributes
syn keyword cssFontAttr contained weight style
# font-weight attributes
syn keyword cssFontAttr contained bold bolder lighter
# font-display attributes
syn keyword cssFontAttr contained auto block swap fallback optional
# TODO: font-variant-* attributes
#------------------------------------------------

# Webkit specific property/attributes
syn keyword cssFontProp contained font-smooth
syn match cssFontAttr contained "\<\%(subpixel-\)\=\antialiased\>"


# CSS Multi-column Layout Module
# http://www.w3.org/TR/css3-multicol/
syn keyword cssMultiColumnProp contained break-after break-before break-inside
syn keyword cssMultiColumnProp contained column-count column-fill column-gap column-rule-color column-rule-style column-rule-width column-rule column-span column-width
syn keyword cssMultiColumnProp contained columns
syn keyword cssMultiColumnAttr contained balance medium
syn keyword cssMultiColumnAttr contained always left right page column
syn keyword cssMultiColumnAttr contained avoid-page avoid-column avoid

# http://www.w3.org/TR/css3-break/#page-break
syn keyword cssMultiColumnProp contained page-break-before page-break-after page-break-inside page

# http://www.w3.org/TR/SVG11/interact.html
syn keyword cssInteractProp contained pointer-events
syn match cssInteractAttr contained "\<\%(visible\)\=\%(Painted\|Fill\|Stroke\)\=\>"

# TODO find following items in w3c docs.
syn keyword cssGeneratedContentProp contained quotes crop
syn keyword cssGeneratedContentProp contained counter-reset counter-increment
syn keyword cssGeneratedContentProp contained move-to
syn keyword cssGeneratedContentProp contained page-policy
syn keyword cssGeneratedContentAttr contained no-open-quote no-close-quote open-quote close-quote

# https://www.w3.org/TR/css-grid-1/
syn keyword cssGridProp contained grid
syn keyword cssGridProp contained grid-template-columns grid-template-rows grid-template-areas grid-template
syn keyword cssGridProp contained grid-column-start grid-column-end grid-column-gap grid-column grid-row-start grid-row-end grid-row-gap grid-row column-start column-end column-gap column row-start row-end row-gap row
syn keyword cssGridProp contained grid-area grid-gap
syn keyword cssGridProp contained gap
syn keyword cssGridProp contained grid-auto-flow grid-auto-rows grid-auto-columns

syn keyword cssHyerlinkProp contained target-name target-new target-position target

syn keyword cssListProp contained list-style-type list-style-position list-style-image list-style
syn keyword cssListAttr contained lower-roman lower-alpha lower-greek lower-latin upper-roman upper-alpha upper-greek upper-latin
syn keyword cssListAttr contained hiragana-iroha hiragana katakana-iroha katakana
syn keyword cssListAttr contained decimal-leading-zero decimal cjk-ideographic
syn keyword cssListAttr contained disc circle square hebrew armenian georgian
syn keyword cssListAttr contained inside outside

# object-fit https://www.w3.org/TR/css-images-3/#the-object-fit
syn keyword cssObjectProp contained object-fit object-position
syn keyword cssObjectAttr contained fill contain cover scale-down

syn keyword cssPositioningProp contained bottom clear clip display float left
syn keyword cssPositioningProp contained position right top visibility
syn keyword cssPositioningProp contained z-index
syn keyword cssPositioningAttr contained block compact grid
syn keyword cssPositioningAttr contained table-row-group table-header-group table-footer-group table-row table-column-group table-column table-cell table-caption table
syn keyword cssPositioningAttr contained left right both
syn keyword cssPositioningAttr contained list-item
syn keyword cssPositioningAttr contained inline-block inline-box inline-table inline-grid inline-flex inline
syn keyword cssPositioningAttr contained flow-root flow
syn keyword cssPositioningAttr contained static relative absolute fixed subgrid sticky

syn keyword cssPrintAttr contained landscape portrait crop cross always

syn keyword cssTableProp contained caption-side table-layout border-collapse border-spacing empty-cells
syn keyword cssTableAttr contained fixed collapse separate show hide once always


syn keyword cssTextProp contained color direction hyphens
syn keyword cssTextProp word-spacing letter-spacing text-decoration text-transform text-align text-index text-shadow text vertical-align unicode-bidi line-height
syn keyword cssTextProp contained text-justify text-outline text-warp text-align-last text-size-adjust text-rendering text-stroke text-indent
syn keyword cssTextProp contained word-break line-break overflow-wrap word-wrap
syn keyword cssTextProp contained white-space
syn keyword cssTextProp contained hanging-punctuation
syn keyword cssTextProp contained tab-size
syn keyword cssTextProp contained punctuation-trim
syn keyword cssTextAttr contained line-through
syn keyword cssTextAttr contained text-top text-bottom top bottom
syn keyword cssTextAttr contained ltr rtl embed nowrap
syn keyword cssTextAttr contained underline overline blink sub super middle
syn keyword cssTextAttr contained capitalize uppercase lowercase
syn keyword cssTextAttr contained justify baseline sub super
syn keyword cssTextAttr contained optimizeLegibility optimizeSpeed geometricPrecision
syn keyword cssTextAttr contained pre-line pre-wrap pre
syn keyword cssTextAttr contained allow-end force-end
syn keyword cssTextAttr contained start end adjacent
syn keyword cssTextAttr contained inter-word inter-ideographic inter-cluster
syn keyword cssTextAttr contained distribute kashida first last
syn keyword cssTextAttr contained clip ellipsis unrestricted suppress
syn keyword cssTextAttr contained break-all
syn keyword cssTextAttr contained break-word
syn keyword cssTextAttr contained manual
syn keyword cssTextAttr contained bidi-override

syn keyword cssTransformProp contained transform-origin transform-style transform
syn keyword cssTransformProp contained perspective-origin perspective
syn keyword cssTransformProp contained backface-visibility

# CSS Transitions
# http://www.w3.org/TR/css3-transitions/
syn match cssTransitionProp contained "\<transition\%(-\%(delay\|duration\|property\|timing-function\)\)\=\>"

# transition-time-function attributes
syn match cssTransitionAttr contained "\<linear\%(-gradient\)\@!\>"
syn keyword cssTransitionAttr contained ease-in-out ease-out ease-in ease
syn keyword cssTransitionAttr contained step-start step-end step
#------------------------------------------------
# CSS Basic User Interface Module Level 3 (CSS3 UI)
# http://www.w3.org/TR/css3-ui/
syn keyword cssUIProp contained box-sizing
syn keyword cssUIAttr contained content-box content padding-box padding border-box border

syn keyword cssUIProp contained cursor
syn match cssUIAttr contained "\<\%(\%([ns]\=[ew]\=\)\|col\|row\|nesw\|nwse\)-resize\>"
syn keyword cssUIAttr contained crosshair help move pointer alias copy
syn keyword cssUIAttr contained progress wait text cell move
syn keyword cssUIAttr contained context-menu
syn keyword cssUIAttr contained no-drop
syn keyword cssUIAttr contained not-allowed
syn keyword cssUIAttr contained all-scroll
syn keyword cssUIAttr contained vertical-text text
syn keyword cssUIAttr contained zoom-in zoom-out zoom

syn keyword cssUIProp contained ime-mode
syn keyword cssUIAttr contained active inactive disabled

syn keyword cssUIProp contained nav-down nav-index nav-left nav-right nav-up nav-
syn keyword cssUIProp contained outline-width outline-style outline-color outline-offset outline
syn keyword cssUIAttr contained invert

syn keyword cssUIProp contained icon resize
syn keyword cssUIAttr contained both horizontal vertical

syn keyword cssUIProp contained text-overflow
syn keyword cssUIAttr contained clip ellipsis

syn keyword cssUIProp contained image-rendering
syn keyword cssUIAttr contained pixellated
syn keyword cssUIAttr contained crisp-edges

#------------------------------------------------
# Webkit/iOS specific attributes
syn keyword cssUIAttr contained preserve-3d
# IE specific attributes
syn keyword cssIEUIAttr contained bicubic

# Webkit/iOS specific properties
syn keyword cssUIProp contained tap-highlight-color user-select touch-callout
# IE specific properties
syn keyword cssIEUIProp contained interpolation-mode zoom filter

# Webkit/Firebox specific properties/attributes
syn keyword cssUIProp contained appearance
syn keyword cssUIAttr contained window button field icon document menu


syn keyword cssAuralProp contained pause-before pause-after pause cue-before cue-after cue
syn keyword cssAuralProp contained play-during speech-rate voice-family pitch-range pitch speak-punctuation speak-numeral speak-header speak
syn keyword cssAuralProp contained volume during azimuth elevation stress richness
syn keyword cssAuralAttr contained x-soft x-loud soft loud
syn keyword cssAuralAttr contained silent
syn keyword cssAuralAttr contained spell-out
syn keyword cssAuralAttr contained non mix
syn keyword cssAuralAttr contained left-side right-side
syn keyword cssAuralAttr contained far-left far-center far-right center-left center-center center-right
syn keyword cssAuralAttr contained leftwards rightwards behind
syn keyword cssAuralAttr contained below level above lower higher
syn keyword cssAuralAttr contained x-slow x-fast x-low x-high slow fast low high
syn keyword cssAuralAttr contained faster slower
syn keyword cssAuralAttr contained male female child code digits continuous

# mobile text
syn keyword cssMobileTextProp contained text-size-adjust

syn keyword cssMediaProp contained width height orientation scan
syn keyword cssMediaProp contained any-hover any-pointer color-gamut grid hover
syn keyword cssMediaProp contained overflow-block overflow-inline pointer update
syn match cssMediaProp contained /\<\%(\%(max\|min\)-\)\=\%(\%(device\)-\)\=aspect-ratio\>/
syn match cssMediaProp contained /\<\%(\%(max\|min\)-\)\=device-pixel-ratio\>/
syn match cssMediaProp contained /\<\%(\%(max\|min\)-\)\=device-\%(height\|width\)\>/
syn match cssMediaProp contained /\<\%(\%(max\|min\)-\)\=\%(height\|width\|resolution\|monochrome\|color\%(-index\)\=\)\>/
syn keyword cssMediaAttr contained portrait landscape progressive interlace
syn keyword cssMediaAttr contained coarse fast fine hover infinite p3 paged
syn keyword cssMediaAttr contained rec2020 scroll slow srgb
syn match cssKeyFrameProp contained /\%(\d\+\%(\.\d\+\)\?%\|\%(\<from\|to\>\)\)/ nextgroup=cssDefinition
syn match cssPageMarginProp /@\%(\%(top\|left\|right\|bottom\)-\%(left\|center\|right\|middle\|bottom\)\)\%(-corner\)\=/ contained nextgroup=cssDefinition
syn keyword cssPageProp contained content size
syn keyword cssPageProp contained orphans widows
syn keyword cssFontDescriptorProp contained src
syn keyword cssFontDescriptorProp contained unicode-range
# unicode-range attributes
syn match cssFontDescriptorAttr contained "U+[0-9A-Fa-f?]\+"
syn match cssFontDescriptorAttr contained "U+\x\+-\x\+"

syn match cssAnyProp contained "\<\%(--\)\@!\a[-a-zA-Z0-9_]*\ze\s*:[^{]*\%(;\|}\|$\)"
syn match cssVendorProp contained "\a[-a-zA-Z0-9_]*\ze\s*:"
syn match cssAtKeyword "@\%(layer\|container\|property\|scope\|starting-style\)\>"
syn match cssBraces contained "[{}]"
syn match cssError contained "{@<>"
syn region cssDefinition transparent matchgroup=cssBraces start='{' end='}' contains=cssAnyProp,cssTagName,cssAttributeSelector,cssClassName,cssIdentifier,cssAtRule,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssCustomProp,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise fold
syn match cssBraceError "}"
syn match cssAttrComma ","

# Pseudo class
# https://www.w3.org/TR/selectors-4/
syn match cssPseudoClass ":[A-Za-z0-9_-]*" contains=cssNoise,cssPseudoClassId,cssUnicodeEscape,cssVendor,cssPseudoClassFn
syn keyword cssPseudoClassId contained link visited active hover before after left right
syn keyword cssPseudoClassId contained root empty target enabled disabled checked invalid
syn keyword cssPseudoClassId contained first-line first-letter
syn keyword cssPseudoClassId contained first-of-type first-child last-of-type last-child only-of-type only-child
syn keyword cssPseudoClassId contained focus-within focus-visible focus
syn region cssPseudoClassFn contained matchgroup=cssFunctionName start="\<\%(not\|is\|lang\|\%(nth\|nth-last\)-\%(of-type\|child\)\)(" end=")" contains=cssStringQ,cssStringQQ,cssTagName,cssAttributeSelector,cssClassName,cssIdentifier
# ------------------------------------
# Vendor specific properties
syn keyword cssPseudoClassId contained selection
syn keyword cssPseudoClassId contained input-placeholder placeholder

# Misc highlight groups
syntax match cssNoise contained /\%(:\|;\|\/\)/

# Comment
syn region cssComment start="/\*" end="\*/" contains=@Spell fold

syn match cssUnicodeEscape "\\\x\{1,6}\s\?"
syn match cssSpecialCharQQ +\\\\\|\\"+ contained
syn match cssSpecialCharQ +\\\\\|\\'+ contained
syn region cssStringQQ start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=cssUnicodeEscape,cssSpecialCharQQ
syn region cssStringQ start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=cssUnicodeEscape,cssSpecialCharQ

# Vendor Prefix
syn match cssVendor contained "-\%(webkit\|moz\|o\|ms\)-"

# Various CSS Hack characters
# In earlier versions of IE (6 and 7), one can prefix property names
# with a _ or * to isolate those definitions to particular versions of IE
# This is purely decorative and therefore we assign to the same highlight
# group to cssVendor, for more information:
# http://www.paulirish.com/2009/browser-specific-css-hacks/
syn match cssHacks contained /\%(_\|*\)/

# Attr Enhance
# Some keywords are both Prop and Attr, so we have to handle them
# cssPseudoClassId is hidden by cssAttrRegion, so we add it here. see #69
syn region cssAttrRegion start=/:/ end=/\ze\%(;\|)\|}\|{\)/ contained contains=cssPseudoClassId,css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise

# Hack for transition
# 'transition' has Props after ':'.
syn region cssAttrRegion start=/transition\s*:/ end=/\ze\%(;\|)\|}\)/ contained contains=css.*Prop,css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise

syn match cssAtKeyword /@\%(font-face\|media\|keyframes\|import\|charset\|namespace\|page\|supports\)/

syn keyword cssAtRuleLogical only not and contained

# @media
# Reference: http://www.w3.org/TR/css3-mediaqueries/
syn region cssAtRule start=/@media\>/ end=/\ze{/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssMediaProp,cssValueLength,cssAtRuleLogical,cssValueInteger,cssMediaAttr,cssVendor,cssMediaType,cssComment,cssCustomProp,cssFunctionName nextgroup=cssDefinition
syn keyword cssMediaType contained screen print aural braille embossed handheld projection tty tv speech all contained

# @page
# http://www.w3.org/TR/css3-page/
syn region cssAtRule start=/@page\>/ end=/\ze{/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssPagePseudo,cssComment nextgroup=cssDefinition
syn match cssPagePseudo /:\%(left\|right\|first\|blank\)/ contained skipwhite skipnl
# @keyframe
# http://www.w3.org/TR/css3-animations/#keyframes
syn region cssAtRule start=/@\%(-[a-z]\+-\)\=keyframes\>/ end=/\ze{/ skipwhite skipnl matchgroup=cssAtKeyword contains=cssVendor,cssComment nextgroup=cssDefinition

syn region cssAtRule start=/@import\>/    end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword,cssURL,cssMediaProp,cssValueLength,cssAtRuleLogical,cssValueInteger,cssMediaAttr,cssMediaType
syn region cssAtRule start=/@charset\>/   end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword
syn region cssAtRule start=/@namespace\>/ end=/\ze;/ contains=cssStringQ,cssStringQQ,cssUnicodeEscape,cssComment,cssAtKeyword

# @supports
# https://www.w3.org/TR/css3-conditional/#at-supports
syn region cssAtRule start=/@supports\>/ end=/\ze{/ skipwhite skipnl contains=cssAtRuleLogical,cssAttrRegion,css.*Prop,cssValue.*,cssVendor,cssAtKeyword,cssComment nextgroup=cssDefinition


if g:main_syntax == "css"
  syn sync minlines=10
  syn sync match cssSync grouphere NONE "^\s*}\s*$"
endif

# Define the default highlighting.
# Only when an item doesn't have highlighting yet

hi def link cssComment Comment
hi def link cssVendor Comment
hi def link cssHacks Comment
hi def link cssTagName Statement
hi def link cssDeprecated Error
hi def link cssSelectorOp Special
hi def link cssSelectorOp2 Special
hi def link cssAttrComma Special

hi def link cssAnimationProp cssProp
hi def link cssBackgroundProp cssProp
hi def link cssBorderProp cssProp
hi def link cssBoxProp cssProp
hi def link cssCascadeProp cssProp
hi def link cssColorProp cssProp
hi def link cssContentForPagedMediaProp cssProp
hi def link cssDimensionProp cssProp
hi def link cssFlexibleBoxProp cssProp
hi def link cssFontProp cssProp
hi def link cssGeneratedContentProp cssProp
hi def link cssGridProp cssProp
hi def link cssHyerlinkProp cssProp
hi def link cssInteractProp cssProp
hi def link cssLineboxProp cssProp
hi def link cssListProp cssProp
hi def link cssMarqueeProp cssProp
hi def link cssMultiColumnProp cssProp
hi def link cssPagedMediaProp cssProp
hi def link cssPositioningProp cssProp
hi def link cssObjectProp cssProp
hi def link cssPrintProp cssProp
hi def link cssRubyProp cssProp
hi def link cssSpeechProp cssProp
hi def link cssTableProp cssProp
hi def link cssTextProp cssProp
hi def link cssTransformProp cssProp
hi def link cssTransitionProp cssProp
hi def link cssUIProp cssProp
hi def link cssIEUIProp cssProp
hi def link cssAuralProp cssProp
hi def link cssRenderProp cssProp
hi def link cssMobileTextProp cssProp

hi def link cssAnimationAttr cssAttr
hi def link cssBackgroundAttr cssAttr
hi def link cssBorderAttr cssAttr
hi def link cssBoxAttr cssAttr
hi def link cssContentForPagedMediaAttr cssAttr
hi def link cssDimensionAttr cssAttr
hi def link cssFlexibleBoxAttr cssAttr
hi def link cssFontAttr cssAttr
hi def link cssGeneratedContentAttr cssAttr
hi def link cssGridAttr cssAttr
hi def link cssHyerlinkAttr cssAttr
hi def link cssInteractAttr cssAttr
hi def link cssLineboxAttr cssAttr
hi def link cssListAttr cssAttr
hi def link cssMarginAttr cssAttr
hi def link cssMarqueeAttr cssAttr
hi def link cssMultiColumnAttr cssAttr
hi def link cssPaddingAttr cssAttr
hi def link cssPagedMediaAttr cssAttr
hi def link cssPositioningAttr cssAttr
hi def link cssObjectAttr cssAttr
hi def link cssGradientAttr cssAttr
hi def link cssPrintAttr cssAttr
hi def link cssRubyAttr cssAttr
hi def link cssSpeechAttr cssAttr
hi def link cssTableAttr cssAttr
hi def link cssTextAttr cssAttr
hi def link cssTransformAttr cssAttr
hi def link cssTransitionAttr cssAttr
hi def link cssUIAttr cssAttr
hi def link cssIEUIAttr cssAttr
hi def link cssAuralAttr cssAttr
hi def link cssRenderAttr cssAttr
hi def link cssCascadeAttr cssAttr
hi def link cssCommonAttr cssAttr

hi def link cssPseudoClassId PreProc
hi def link cssPseudoClassLang Constant
hi def link cssValueLength Number
hi def link cssValueInteger Number
hi def link cssValueNumber Number
hi def link cssValueAngle Number
hi def link cssValueTime Number
hi def link cssValueFrequency Number
hi def link cssFunction Constant
hi def link cssURL String
hi def link cssFunctionName Function
hi def link cssFunctionComma Function
hi def link cssColor Constant
hi def link cssIdentifier Function
hi def link cssAtRule Include
hi def link cssAtKeyword PreProc
hi def link cssImportant Special
hi def link cssCustomProp Special
hi def link cssBraces Function
hi def link cssBraceError Error
hi def link cssError Error
hi def link cssUnicodeEscape Special
hi def link cssStringQQ String
hi def link cssStringQ String
hi def link cssAttributeSelector String
hi def link cssMediaType Special
hi def link cssMediaComma Normal
hi def link cssAtRuleLogical Statement
hi def link cssMediaProp cssProp
hi def link cssMediaAttr cssAttr
hi def link cssPagePseudo PreProc
hi def link cssPageMarginProp cssAtKeyword
hi def link cssPageProp cssProp
hi def link cssKeyFrameProp Constant
hi def link cssFontDescriptor Special
hi def link cssFontDescriptorProp cssProp
hi def link cssFontDescriptorAttr cssAttr
hi def link cssUnicodeRange Constant
hi def link cssClassName Function
hi def link cssClassNameDot Function
hi def link cssProp StorageClass
hi def link cssAnyProp cssProp
hi def link cssVendorProp cssProp
hi def link cssAttr Constant
hi def link cssNoise Noise

b:current_syntax = "css"

if g:main_syntax == 'css'
  unlet g:main_syntax
endif


# vim: ts=8

&regexpengine = keepre
