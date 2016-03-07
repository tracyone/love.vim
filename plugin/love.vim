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
let g:love_support_option = ["cmdheight","gfn","gfw","listchars"]

let g:love_config_file = $VIMFILES."/love.ini"

command! Love call s:Love()

" write to ini file
function! s:Love()
    echom "Saving setting ..."
    let l:tmp_dict = {"basic":{}}
    for l:i in g:love_support_option
        let l:tmp_dict["basic"][l:i]=s:GetOptionValue(l:i)
    endfor
    call IniParser#Write(l:tmp_dict,g:love_config_file)
endfunction

function! s:GetOptionValue(option)
    redir => l:x
    silent! exec "echo &".a:option 
    redir END
    return l:x
endfunction

" read then apply setting
function! s:Apply()
    let l:tmp_dict = IniParser#Read(g:love_config_file)
    for l:i in g:love_support_option
        exec "set ".l:i."=".escape(l:tmp_dict["basic"][l:i],' \|')
    endfor
endfunction

call s:Apply()

let g:loaded_love = 1
let &cpo = s:save_cpo
unlet s:save_cpo
