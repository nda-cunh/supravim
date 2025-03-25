vim9script

command -nargs=* Coplien :call Coplien(<f-args>)

def Coplien(class: string)
	var name = substitute(class, '^.*/', '', '')
	var path = substitute(class, name .. '$', '', '') 

	exec "tabnew " .. path .. name .. ".hpp"
	setline(1, '#ifndef ' .. toupper(name) .. '_HPP')
	append(line('$'), '# define ' .. toupper(name) .. '_HPP')
	append(line('$'), '')
	append(line('$'), 'name ' .. name)
	append(line('$'), '{')
	append(line('$'), '	public:')
	append(line('$'), '		' .. name .. '();')
	append(line('$'), '		~' .. name .. '();')
	append(line('$'), '		' .. name .. ' (const ' .. name .. ' &copy);')
	append(line('$'), '		' .. name .. ' &operator=(const ' .. name .. '&);')
	append(line('$'), '	private:')
	append(line('$'), '		')
	append(line('$'), '};')
	append(line('$'), '')
	append(line('$'), '#endif')
	silent w
	exec "vs " .. path .. name .. ".cpp"

	setline(1, "#include \"" .. name .. ".hpp\"")
	append(line('$'), '')
	append(line('$'), name .. '::' .. name .. '() {')
	append(line('$'), '}')
	append(line('$'), '')
	append(line('$'), name .. '::~' .. name .. '() {')
	append(line('$'), '}')
	append(line('$'), '')
	append(line('$'), name .. '::' .. name .. '(const ' .. name .. ' &copy) {')
	append(line('$'), '	*this = copy;')
	append(line('$'), '}')
	append(line('$'), '')
	append(line('$'), name .. ' & ' .. name .. '::operator=(const ' .. name .. ' &copy) {')
	append(line('$'), '	if (&copy != this) {')
	append(line('$'), '		')
	append(line('$'), '	}')
	append(line('$'), '	return (*this);')
	append(line('$'), '}')
	silent w
enddef
