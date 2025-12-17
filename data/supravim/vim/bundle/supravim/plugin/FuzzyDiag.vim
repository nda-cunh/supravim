vim9script

import autoload 'fuzzbox/_extensions/fuzzydiag.vim' as Diag

command! FuzzyLspDiag call Diag.Start()
