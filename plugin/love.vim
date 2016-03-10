"=============================================================================
" FILE: love.vim
" AUTHOR:  tracyone <tracyone@live.cn>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
if exists("g:loaded_love") || &compatible
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

" Core command
if !exists('g:love_support_option')
let g:love_support_option = ["cmdheight","gfn","gfw","linespace",
            \"nu","rnu","ic","wrap","et","mouse","ls","stal","go",
            \"bg","fenc","sh"]
endif

if !exists('g:love_config_file')
    let g:love_config_file = $VIMFILES."/love.ini"
endif

command! Love call s:Love()
command! LoveClean call s:LoveClean()


" write to ini file
function! s:Love()
    if  filereadable(g:love_config_file)
        let l:tmp_dict = IniParser#Read(g:love_config_file)
    else
        let l:tmp_dict = {"basic":{},"advance":{}}
    endif

    for l:i in g:love_support_option
        let l:new_val =s:GetOptionValue(l:i)
        let l:is_key_exist = get(l:tmp_dict["basic"],l:i,-99)

        "exist and not equal
        if  l:is_key_exist != -99 && l:tmp_dict["basic"][l:i] != l:new_val
            let l:tmp_dict["basic"][l:i]=l:new_val
        elseif l:is_key_exist == -99  
            let l:tmp_dict["basic"][l:i]=l:new_val
        endif
    endfor
    "specfial option &advance
    if exists('g:colors_name')
        let l:is_key_exist = get(l:tmp_dict["advance"],l:i,-99)
        if l:is_key_exist != -99 && l:tmp_dict["advance"]["colorscheme"] != g:colors_name
            let l:tmp_dict["advance"]["colorscheme"]=g:colors_name
        elseif l:is_key_exist == -99
            let l:tmp_dict["advance"]["colorscheme"]=g:colors_name
        endif
    endif

    let l:ret = IniParser#Write(l:tmp_dict,g:love_config_file)
    "return list if success
    if type(l:ret) != type([])
        call s:EchoWarning("Save falied!Please check the file permission.")
    else
        call s:EchoWarning("Setting have been saved!") 
    endif
endfunction

" clear config file
"
function s:LoveClean()
    if !delete(g:love_config_file)
        call s:EchoWarning(g:love_config_file." has been deleted from disk")
    endif
endfunction

function! s:GetOptionValue(option)
    redir => l:x
    silent! exec "echo &".a:option 
    redir END
    return l:x
endfunction

" read then apply setting
function! s:Apply()
    if filereadable(g:love_config_file)
        let l:tmp_dict = IniParser#Read(g:love_config_file)
        if type(l:tmp_dict) == type({})
            for l:i in g:love_support_option
                let l:is_key_exist =  get(l:tmp_dict["basic"],l:i,-99)
                if  l:is_key_exist != -99 
                    if  l:i =~ '\v^g(f[nw])|(uifont(wide)?)$' && l:tmp_dict["basic"][l:i] == ""
                        continue  "ignore empty gui font setting
                    endif
                    if l:tmp_dict["basic"][l:i] =~ '\v^\d+$'
                        exec ":let &" .l:i ."=" .l:tmp_dict["basic"][l:i]
                    else
                        exec "set ".l:i."=".escape(l:tmp_dict["basic"][l:i],' \|')
                    endif
                else
                    if l:is_key_exist == -99 | call s:EchoWarning("No Such key: ".l:i.",try :LoveClean") | endif
                endif
            endfor
            if get(l:tmp_dict["advance"],"colorscheme",-99) != -99
                exec "colorscheme ".l:tmp_dict["advance"]["colorscheme"]
            else
                call s:EchoWarning("No Such key!Try :LoveClean first.")
            endif
        else
            call s:EchoWarning("Apply failed.Try :LoveClean first.")
        endif
    endif
endfunction

func! s:EchoWarning(str)
    echohl WarningMsg | echo a:str | echohl None
endfunc

call s:Apply()

let g:loaded_love = 1
let &cpo = s:save_cpo
unlet s:save_cpo
