# Introdution

Save your basic vim setting without modifing your vimrc!

All you need to do is:

1. Start gvim/vim
2. do some vim option setting in cmd window, for example

	```vim
	:set nonu  
	:colorscheme desert
    :set go-=mT   "no toolbar and menu in gvim
    :set fenc=utf-8  "creat file with utf-8 encode
	```

3. execute :Love

	```vim
    "save setting
    :Love
	```
4. clean love

	```vim
    "restore factory(==!) setting
    :LoveClean
	```

# Installation

Use [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tracyone/love.vim'
```

# config example

You don't need to do any config.But you can do it anyway

```vim

"Default setting

" default support option,you can add others but save aciton mightbe failed 
"beause of some autocomand or filetype detection or some Plugin

let g:love_support_option = ["cmdheight","gfn","gfw","listchars",
            \"nu","rnu","ic","wrap","et","mouse","ls","stal","go",
            \"bg","fenc"]

"The location of config file,this Plugin read write this file automatically"
let g:love_config_file = $VIMFILES."/love.ini"

```

**note**:colorscheme setting is also support.

# TODO

1. Document
