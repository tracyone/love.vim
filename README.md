# love.vim

[![Build Status](https://travis-ci.org/tracyone/love.vim.svg)](https://travis-ci.org/tracyone/love.vim)
[![Doc](https://img.shields.io/badge/doc-%3Ah%20love.txt-orange.svg)](doc/love.txt)


<!-- vim-markdown-toc GFM -->

* [Introdution](#introdution)
* [Installation](#installation)
* [config example](#config-example)

<!-- vim-markdown-toc -->
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
    "save settings
    :Love
	```

4. Next time you start vim/gvim,you will find out,your settings  
have been applied.

5. clean love. you can clear your save config by executing following command.

	```vim
    "delete settings
    :LoveClean
	```

6. Maybe you want to save your settings just for current directory(project root?), love.vim can also save setting in current directory

```vim
"save settings in current directory
:Love 1
"delete settings in current directory
:LoveClean 1
```

# Installation

It has been tested in MS Windows, Mac OSX and `*nix`

Use [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tracyone/love.vim'
```

# config example

You don't need to do any config.But you can do it anyway

**default support option is:**

 Options    | Function
 ------     | -------
`cmdheight` | the height of cmd window
`gfn`       | gui font
`gfw`       | gui font for wide char
`linespace` | line space width in gui
`nu`        | absolutely line number
`rnu`       | releative line number
`mouse`     | mouse type
`ls`        | whether show status line or not
`stal`      | whether show tab line
`go`        | gui option
`bg`        | background type
`fenc`      | file encode type
`sh`        | shell type

```vim

" You can add other options but save aciton mightbe failed "
"beause of some autocommands or filetype detection or some Plugins
let g:love_support_option=["cul","textwidth"]
let g:love_gui_support_option=['guicursor']

"The location of config file,this Plugin read write this file automatically"
let g:love_config_file = $VIMFILES."/.love.vim"
"The location of config file,this Plugin read write this file automatically"
let g:love_gui_config_file = $VIMFILES."/.gui_love.vim"

```

**NOTE**:colorscheme setting is also support.

