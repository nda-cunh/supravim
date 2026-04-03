vim9script

import autoload 'fuzzbox/_extensions/fuzzydiag.vim' as Diag
import autoload 'fuzzbox/_extensions/fuzzymake.vim' as Make 
import autoload 'fuzzbox/_extensions/fuzzymark.vim' as Mark
import autoload 'fuzzbox/_extensions/fuzzytags.vim' as Tags
import autoload 'fuzzbox/_extensions/fuzzyclip.vim' as Clip

command! FuzzyLspDiag call Diag.Start()
command! FuzzyMake call Make.Start()
command! FuzzyMark call Mark.Start()
command! FuzzySupraTags call Tags.Start()
command! FuzzyClip call Clip.Start()
