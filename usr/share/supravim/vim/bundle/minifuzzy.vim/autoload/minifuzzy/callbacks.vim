vim9script

# Exec callbacks
export const EditArg = (arg: string): string => execute($"edit {arg}")
export const SplitArg = (arg: string): string => execute($"split {arg}")
export const VsplitArg = (arg: string): string => execute($"vsplit {arg}")
export const EchoArg = (arg: string): string => execute($"echo {string(arg)}", "")
export const GotoLineNumberArg = (arg: string): string => execute($"exec 'normal m`' | :{arg} | norm zz")
export const SplitLineNumberArg = (arg: string): string => execute($"exec 'normal m`' | sp | :{arg} | norm zz")
export const VsplitLineNumberArg = (arg: string): string => execute($"exec 'normal m`' | vs | :{arg} | norm zz")

# Format callbacks
export const DefaultFormatArg = (arg: string): string => arg
export const GetBufLineByNumber = (arg: string): string => repeat(" ", len(string(line('$'))) - len(arg)) .. arg .. " " .. (len(getbufline(bufname(), str2nr(arg))) > 0 ? getbufline(bufname(), str2nr(arg))[0] : "")

# Cancel callbacks
export const DefaultCancel = () => null
