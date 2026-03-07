vim9script noclear

if exists('g:LspInterfaceLoaded')
	finish
endif

g:LspInterfaceLoaded = 1

try
	import autoload 'LspInterface/LspInterface.vim' as Lsp

### LSP Interface settings

def g:AddLspServer(name: string, cmd: list<string>, filetypes: list<string>)
	Lsp.AddLspServer(name, cmd, filetypes)
enddef

def g:AutoLspHold()
	Lsp.AutoLspHold()
enddef

def g:AutoSaveActivate(activate: bool)
	Lsp.AutoSaveActivate(activate)
enddef

def g:RenameSymbol()
	Lsp.RenameSymbol()
enddef

def g:LspServerActivate()
	Lsp.LspServerActivate()
enddef

# --- Navigation avancée ---

def g:LspDefinition()
	Lsp.LspDefinition()
enddef

def g:LspDeclaration()
	Lsp.LspDeclaration()
enddef

def g:LspTypeDefinition()
    Lsp.LspTypeDefinition()
enddef

def g:LspReferences()
    Lsp.LspReferences()
enddef

def g:LspImplementation()
    Lsp.LspImplementation()
enddef

# --- Aide et Documentation ---

def g:LspHover()
    Lsp.LspHover()
enddef

def g:LspSignatureHelp()
    Lsp.LspSignatureHelp()
enddef

# --- Actions et Correction ---

def g:LspCodeAction()
    Lsp.LspCodeAction()
enddef

def g:LspFormat()
    Lsp.LspFormat()
enddef

# --- Diagnostics (Erreurs/Warnings) ---

def g:LspNextDiagnostic()
    Lsp.LspNextDiagnostic()
enddef

def g:LspPrevDiagnostic()
    Lsp.LspPrevDiagnostic()
enddef

def g:LspShowDiagnostics()
    Lsp.LspShowDiagnostics()
enddef

# --- Symboles ---

def g:LspDocumentSymbol()
    Lsp.LspDocumentSymbol()
enddef

def g:LspWorkspaceSymbol()
    Lsp.LspWorkspaceSymbol()
enddef

def g:BalloonPopup(): string
	return Lsp.BalloonPopup()
enddef

catch
#################################################
### Fake implementations if the LspInterface plugin is not available
#################################################

const LspInterfaceNotFoundMessage = "LspInterface plugin not found. Please install it to use LSP features."

def g:AddLspServer(name: string, cmd: list<string>, filetypes: list<string>)
	echom LspInterfaceNotFoundMessage
enddef

def g:AutoLspHold()
	echom LspInterfaceNotFoundMessage
enddef

def g:AutoSaveActivate(activate: bool)
	echom LspInterfaceNotFoundMessage
enddef

def g:RenameSymbol()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspServerActivate()
	echom LspInterfaceNotFoundMessage
enddef

# --- Navigation avancée ---

def g:LspDefinition()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspDeclaration()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspTypeDefinition()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspReferences()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspImplementation()
	echom LspInterfaceNotFoundMessage
enddef

# --- Aide et Documentation ---

def g:LspHover()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspSignatureHelp()
	echom LspInterfaceNotFoundMessage
enddef

# --- Actions et Correction ---

def g:LspCodeAction()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspFormat()
	echom LspInterfaceNotFoundMessage
enddef

# --- Diagnostics (Erreurs/Warnings) ---

def g:LspNextDiagnostic()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspPrevDiagnostic()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspShowDiagnostics()
	echom LspInterfaceNotFoundMessage
enddef

def g:BalloonPopup(): string
	echom LspInterfaceNotFoundMessage
	return ''
enddef

# --- Symboles ---

def g:LspDocumentSymbol()
	echom LspInterfaceNotFoundMessage
enddef

def g:LspWorkspaceSymbol()
	echom LspInterfaceNotFoundMessage
enddef

endtry
