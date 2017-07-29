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

if exists('g:loaded_love') || &compatible
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

" Core command
if !exists('g:love_support_option')
    let g:love_support_option=[]
endif

if !exists('g:love_gui_support_option')
    let g:love_gui_support_option=[]
endif


let s:love_default_option = ['cmdheight', 'nu', 'rnu', 'ic', 'wrap', 
            \ 'et', 'mouse', 'ls', 'stal', 'bg', 'fenc', 'sh', 
            \ 'cul', 'textwidth'] + g:love_support_option

let s:love_gui_default_option = ['gfn', 'gfw', 'go', 'linespace'] + g:love_gui_support_option

if !exists('g:love_config_file')
    if !exists('$VIMFILES')
        if has('unix')
            let $VIMFILES = $HOME.'/vimfiles'
        else
            let $VIMFILES = $HOME.'/.vim'
        endif
    endif
    let g:love_config_file = $VIMFILES.'/.love.vim'
endif

if !exists('g:love_gui_config_file')
    let g:love_gui_config_file = $VIMFILES.'/.gui_love.vim'
endif


" write to ini file
function! love#Love() abort
    if  filereadable(g:love_config_file)
        if delete(g:love_config_file)
            call s:EchoWarning('delete '.g:love_config_file.'failed!')
        endif
    endif
    let l:tmp_list=[]

    for l:i in s:love_default_option
        let l:new_val =s:GetOptionValue(l:i)
        if l:new_val =~# '\v^\d+$'
            call add(l:tmp_list, 'let &'.l:i.'='.l:new_val)
        else
            call add(l:tmp_list, 'set '.l:i.'='.escape(l:new_val, ' \|'))
        endif
    endfor

    let l:ret=0
    if has('gui_running')
        if  filereadable(g:love_gui_config_file)
            if delete(g:love_gui_config_file)
                call s:EchoWarning('delete '.g:love_gui_config_file.'failed!')
            endif
        endif
        let l:tmp_gui_list=[]
        for l:i in s:love_gui_default_option
            let l:new_val =s:GetOptionValue(l:i)
            if l:new_val =~# '\v^\d+$'
                call add(l:tmp_gui_list, 'let &'.l:i.'='.l:new_val)
            else
                call add(l:tmp_gui_list, 'set '.l:i.'='.escape(l:new_val, ' \|'))
            endif
        endfor
        let l:ret += writefile(l:tmp_gui_list, g:love_gui_config_file)
    endif

    "specfial option &advance
    if exists('g:colors_name')
        call add(l:tmp_list, 'colorscheme '.g:colors_name)
    endif

    let l:ret += writefile(l:tmp_list, g:love_config_file)
    "return list if success
    if l:ret != 0
        call s:EchoWarning('Save falied!Please check the file permission.')
    else
        call s:EchoWarning('Setting have been saved!') 
    endif
endfunction

" clear config file
"
function! love#LoveClean() abort
    if !delete(g:love_config_file) && !delete(g:love_gui_config_file)
        call s:EchoWarning('config has been deleted from disk')
    endif
endfunction

function! s:GetOptionValue(option) abort
    return matchstr(eval('&'.a:option),"[^']*")
endfunction

" read then apply setting
function! love#Apply() abort
    if filereadable(g:love_config_file)
        silent! execute 'source '.g:love_config_file
    endif
    if has('gui_running')
        if filereadable(g:love_gui_config_file)
            silent! execute 'source '.g:love_gui_config_file
        endif
    endif
endfunction

func! s:EchoWarning(str) abort
    echohl WarningMsg | echo a:str | echohl None
endfunc


let g:loaded_love = 1
let &cpo = s:save_cpo
unlet s:save_cpo
