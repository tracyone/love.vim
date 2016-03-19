# Introdution

Save your basic vim setting without modifing your vimrc!

All you need to do is:

1. Start gvim/vim
2. do some vim option setting in cmd window or menu

    for example

	```vim
	:set nonu  
	:colorscheme desert
    :set go-=mT   "no toolbar and menu in gvim
    :set fenc=utf-8  "create files with utf-8 encode
	```

3. execute :Love

	```vim
    "save setting
    :Love
	```

4. Next time you start vim/gvim,you will find out,your settings  
have been applied.

5. clean love. you can clear your save config by executing following command.

	```vim
    "restore factory(==!) setting
    :LoveClean
	```

# Installation

It has been tested in MS Windows, Mac OSX and `*nix`

Use [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tracyone/love.vim'
```

# config example

You don't need to do any config.But you can do it anyway

```vim

"Default setting

"default support option,you can add other options but save aciton mightbe failed 
"beause of some autocommands or filetype detection or some Plugins

let g:love_support_option = ["cmdheight","gfn","gfw","linespace",
            \"nu","rnu","ic","wrap","et","mouse","ls","stal","go",
            \"bg","fenc","sh"]

"The location of config file,this Plugin read write this file automatically"
let g:love_config_file = $VIMFILES."/love.ini"

```

**NOTE**:colorscheme setting is also support.

# TODO 

- [ ] Optimize code for saving startup time.

# Special Thanks

IniParser lib is from [xuhdev/vim-IniParser](https://github.com/xuhdev/vim-IniParser)

