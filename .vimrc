"                      `. ___
"                     __,' __`.                _..+--+....____
"         __...++.'``;.   ,.   ;``++..__     .'    ,+._    _.+'
"   _..+''+-----+'   `'   `'   `'     O ``+''._   (,;') _,'
" ,'________________                          \`+._`+','
"  `._              ```````````+----+...___   '+.._'+:
"     ```++.._      ,.                     ````++...__\+.
"             `.++. `+`    perfect.vim        ____    +  +`
"               `. `.                       ,'`````.  ;  ;`
"                 `._`.        __________   `.      \'__/`
"                    `+:._____/______/___/____`.     \  `
"                                +       `._    `.    \
"                                `._________`+.   `.   `.___
"                                              SSt  `+----+'`
"  https://wiki.exos.ninja/perfect.vim
"
"    +----------------------------------------------+
"    |                                              |
"    | DON'T TOUCH THIS FILE, use ~/.vim/config.vim |
"    |                                              |
"    +----------------------------------------------+
"
" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.vim/plugged')

" let g:debug=1

function! s:dlog(msg)
    if exists('g:debug')
        echom a:msg
    endif
endfunction

function! s:setDefault(param, defValue)
    if !exists('g:'. a:param)
        call s:dlog(a:param . " does not defined, set to " . a:defValue)
        execute "let g:" . a:param . " = a:defValue"
    endif
endfunction

function! s:setDefaults(obj)
    for [k, v] in items(a:obj)
        call s:setDefault("".k, "". v)
        unlet k v
    endfor
endfunction

if filereadable(expand('~/.vim/config.vim'))
    call s:dlog("Load config file")
    source ~/.vim/config.vim
endif


" Set ui font
set gfn=CPMono_v07\ Plain\ For\ Powerline\ 9
"set gfn=BitstreamVeraSansMono\ Nerd\ Font\ 10


" UTF8 for everywhere
set encoding=utf8

" no vi-compatible
set nocompatible

call s:setDefaults({
    \ "theme": "wombat",
    \ "gui_theme": "wombat",
    \ "airline_theme": "bubblegum",
    \ "failback_theme": "delek",
    \ "patchedfont": 0,
    \ })

call s:setDefaults({
    \ "enable_nerdtree": 1,
    \ "enable_nerdcommenter": 1,
    \ "enable_tabman": 1,
    \ "enable_undotree": 1,
    \ "enable_airline": 1,
    \ "enable_tagbar": 1,
    \ "enable_ale": 1,
    \ "enable_ycm": 1,
    \ "enable_ultisnips": 1,
    \ "enable_previm": 1,
    \ "enable_ctrlp": 1,
    \ })

call s:setDefaults({
    \ "lang_javascript": 1,
    \ "lang_python": 1,
    \ "lang_ruby": 1,
    \ })

if (g:patchedfont == 1)
    call s:setDefaults({
        \ "icon_add": '✚',
        \ "icon_delete": '✖',
        \ "icon_delete_first_line": '^✖',
        \ "icon_change": '●',
        \ "icon_changedelete": '●',
        \ "icon_untrack": '✭',
        \ "icon_renamed": '➜',
        \ "icon_unmerged": '=',
        \ "icon_dirty": '✗',
        \ "icon_clean": '✔︎',
        \ "icon_ignored": '_',
        \ "icon_unknow": '?',
        \ "icon_error": '✗',
        \ "icon_warning": '⚠',
        \ "icon_expand": '▶',
        \ "icon_expanded": '▼',
        \ })
else
    call s:setDefaults({
        \ "icon_add": '+',
        \ "icon_delete": 'x',
        \ "icon_delete_first_line": '^x',
        \ "icon_change": '*',
        \ "icon_changedelete": '*',
        \ "icon_untrack": '*',
        \ "icon_renamed": 'r_',
        \ "icon_unmerged": '=',
        \ "icon_dirty": 'x',
        \ "icon_clean": '.',
        \ "icon_ignored": '_',
        \ "icon_unknow": '?',
        \ "icon_error": 'X',
        \ "icon_warning": 'W',
        \ "icon_expand": '>',
        \ "icon_expanded": '\/',
        \ })
endif

""" General

" Override configs by directory
Plug 'arielrossanigo/dir-configs-override.vim'

if (g:enable_nerdtree == 1)
    " Better file browser
    Plug 'scrooloose/nerdtree'
    " NerdTree and Tabs together
    Plug 'jistr/vim-nerdtree-tabs'
    " Git support for NerdTree
    Plug 'Xuyuanp/nerdtree-git-plugin'
endif

if (g:enable_nerdcommenter == 1)
    " Comment functions so powerful—no comment necessary.
    Plug 'scrooloose/nerdcommenter'
endif

if (g:enable_tabman == 1)
    " Tablist
    Plug 'kien/tabman.vim'
endif

" Find out which project a file belongs to, easy to use in scripts/mappings
Plug 'dbakker/vim-projectroot'

if (g:enable_undotree ==1)
    " The ultimate undo history visualizer for VIM
    Plug 'mbbill/undotree'
endif


if (g:enable_ctrlp == 1)
    " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
    Plug 'ctrlpvim/ctrlp.vim'
endif

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

""" Look and feel

" Adds file type glyphs/icons to many popular Vim plugins such as: NERDTree,
" vim-airline, unite, vim-startify and many more
Plug 'ryanoasis/vim-devicons'

if (g:enable_nerdtree == 1)
    " vim-nerdtree-syntax-highlight
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
endif

if (g:enable_airline == 1)
    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
endif

" Terminal Vim with 256 colors colorscheme
Plug 'fisadev/fisa-vim-colorscheme'
" An enhanced wombat256 color scheme for Vim.
Plug 'sheerun/vim-wombat-scheme'


""" Development

if (g:enable_tagbar == 1)
    " Class/module browser
    Plug 'majutsushi/tagbar'
endif

" Git cool commands
Plug 'tpope/vim-fugitive'
" Sign column from version control system.
Plug 'mhinz/vim-signify'

if (g:enable_ale == 1)
    "Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
    Plug 'w0rp/ale'
endif

" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Surround
Plug 'tpope/vim-surround'
" Autoclose
" There are an issue with YCM (apparently), check
" https://github.com/spf13/spf13-vim/issues/236
" Plug 'Townk/vim-autoclose'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

if (g:enable_ycm == 1)
    " A code-completion engine for Vim
    Plug 'Valloric/YouCompleteMe'
endif

if (g:enable_ultisnips == 1)
    " UltiSnips - The ultimate snippet solution for Vim. Send pull requests to
    " SirVer/ultisnips!
    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'
endif

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

"" Text/Markdown

" Vim Markdown runtime files
Plug 'tpope/vim-markdown'
" Rethinking Vim as a tool for writers
Plug 'reedes/vim-pencil'

if (g:enable_previm == 1)
    " Vim plugin for preview.
    Plug 'kannokanno/previm'
endif

"" HTML/Web

" Emmet integration
Plug 'mattn/emmet-vim'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

""" JavaScript && Node.js

if (g:lang_javascript == 1)
    " Enhanced JavaScript Syntax for Vim
    Plug 'jelera/vim-javascript-syntax'
    " Javascript indenter (HTML indent is included)
    " Plug 'vim-scripts/JavaScript-Indent'
    " Tern plugin for Vim
    Plug 'ternjs/tern_for_vim'
    " Vim Pug (formerly Jade) template engine syntax highlighting and indention
    Plug 'digitaltoad/vim-pug'
    " Standalone JSDoc syntax for vim
    Plug 'othree/jsdoc-syntax.vim'
    " Generate JSDoc to your JavaScript code.
    Plug 'heavenshell/vim-jsdoc'
    " JavaScript Parameter Complete
    Plug 'othree/jspc.vim'
    " JavaScript Context Coloring in Vim
    "Plug 'bigfish/vim-js-context-coloring'
    " React JSX syntax highlighting and indenting for vim.
    Plug 'mxw/vim-jsx'
endif

"" Python

if (g:lang_python == 1)
    " Vim plugin for working with python virtualenvs
    Plug 'jmcantrell/vim-virtualenv'
    " Automatically sort python imports
    Plug 'fisadev/vim-isort'
endif

"" Other langs

" TypeScript
"Plug 'Quramy/tsuquyomi'
" Crystal
"Plug 'vim-crystal'



" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

function! HasConfig(file, dir)
    return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endfunction

function! s:alignMarkdownTable()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" always show status bar
set ls=2

" incremental search
set incsearch

" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line numbers
set nu

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" Use 256 color with theme and fallback
if &term =~? 'mlterm\|xterm\|xterm-256\|screen-256'
    let &t_Co = 256
    execute "colorscheme " . theme
else
    execute "colorscheme " . fallback_theme
endif

" gvim
if has('gui_running')
    execute "colorscheme " . gui_theme
endif

""" Gui options

" Remove menu bar
set guioptions-=m
" Remove toolbar
set guioptions-=T
" Remove right-hand scroll bar
set guioptions-=r
" Remove left-hand scroll bar
set guioptions-=L

""" Some commands

" save as sudo
ca w!! w !sudo tee "%"
" Copy to clipboard
ca copy w !xclip -sel clip

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp
set backup
set backupdir=~/.vim/dirs/backupsv
set undofile
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

""" Maps

" tab navigation mappings
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map tT :tabnew<CR>
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>

" navigate windows with meta+arrows
map <A-Right> <c-w>l
map <A-Left> <c-w>h
map <A-Up> <c-w>k
map <A-Down> <c-w>j
imap <A-Right> <ESC><c-w>l
imap <A-Left> <ESC><c-w>h
imap <A-Up> <ESC><c-w>k
imap <A-Down> <ESC><c-w>j

" simple recursive grep
nmap <leader>r :Ack
nmap <leader>wr :Ack <cword><CR>

" Add ; to final
nmap ;; A;
" Add , to final
nmap ,, A,

" Copy to clipboard
map <leader>cc :w !xsel -i -b<CR>
map <leader>cp :w !xsel -i -p<CR>
map <leader>cs :w !xsel -i -s<CR>
" Paste from clipboard
map <leader>pp :r!xsel -p<CR>
map <leader>ps :r!xsel -s<CR>
map <leader>pb :r!xsel -b<CR>

""" Plugins configuration

""" projectroot

function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

let g:rootmarkers = ['.projectroot', '.git', '.hg', '.svn', '.bzr', '_darcs', 'build.xml', 'package.json']

autocmd BufEnter * call <SID>AutoProjectRootCD()

""" ctrlp

let g:ctrlp_map = '<F5>'
let g:ctrlp_cmd = 'CtrlP'

"" When invoked without an explicit starting directory, CtrlP will set its
"" local working directory according to this variable:
"" 'c' - the directory of the current file.
"" 'a' - the directory of the current file, unless it is a subdirectory of the
""       cwd
"" 'r' - the nearest ancestor of the current file that contains one of these
""       directories or files: .git .hg .svn .bzr _darcs
"" 'w' - modifier to "r": start search from the cwd instead of the current
""       file's directory
""  0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'

"" If a file is already open, open it again in a new pane instead of switching to the existing pane
" let g:ctrlp_switch_buffer = 'et'

let g:ctrlp_root_markers = ['.git', '.hg', '.svn', '.bzr', '_darcs', 'package.json', 'requirements.txt']


let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

""" undotree

if (g:enable_undotree == 1)
    nnoremap <leader>u :UndotreeToggle<cr>
endif

""" YankRing

" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

""" DevIcons
" See https://github.com/ryanoasis/vim-devicons

if (g:patchedfont == 1)
    " loading the plugin
    let g:webdevicons_enable = 1

    " adding the flags to NERDTree
    let g:webdevicons_enable_nerdtree = 1

    " adding to vim-airline's tabline
    let g:webdevicons_enable_airline_tabline = 1

    " adding to vim-airline's statusline
    let g:webdevicons_enable_airline_statusline = 1

    " Force extra padding in NERDTree so that the filetype icons line up vertically
    let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

    " change the default character when no match found
    let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = '!'

    " enable folder/directory glyph flag (disabled by default with 0)
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1

    " enable pattern matching glyphs on folder/directory (enabled by default with 1)
    let g:DevIconsEnableFolderPatternMatching = 1
else
    let g:webdevicons_enable = 0
    let g:webdevicons_enable_nerdtree = 0
    let g:webdevicons_enable_airline_tabline = 0
    let g:webdevicons_enable_airline_statusline = 0
    let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0
    let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = '!'
    let g:WebDevIconsUnicodeDecorateFolderNodes = 0
    let g:DevIconsEnableFolderPatternMatching = 0
endif


""" NerdTree && _NerdTreeTabs
"" See https://github.com/scrooloose/nerdtree/blob/master/README.markdown
"" and https://github.com/jistr/vim-nerdtree-tabs

if (g:enable_nerdtree == 1)

    " Don;t show these file types
    let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\~$', '\.sw[^fv]$']

    " Open NERDTree on gvim/macvim startup. (When set to 2, open only if
    " directory was given as startup argument).
    let g:nerdtree_tabs_open_on_gui_startup = 1

    " Open NERDTree on console vim startup. (When set to 2, open only if
    " directory was given as startup argument).
    let g:nerdtree_tabs_open_on_console_startup = 2

    " Automatically find and select currently opened file in NERDTree.
    let g:nerdtree_tabs_autofind = 1

    "" Styles
    " Highlight full name (not only icons). You need to add this if you don't
    " have vim-devicons and want highlight.
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1

    " enables folder icon highlighting using exact match
    let g:NERDTreeHighlightFolders = 1

    " highlights the folder name
    let g:NERDTreeHighlightFoldersFullName = 1

    if (g:patchedfont == 1)

    "    " Disable Highlighting
    "    let g:NERDTreeDisableFileExtensionHighlight = 1
    "    let g:NERDTreeDisableExactMatchHighlight = 1
    "    let g:NERDTreeDisablePatternMatchHighlight = 1
    "
    "
    "    " this line is needed to avoid error
    "    let g:NERDTreeExtensionHighlightColor = {}
    "
    "    " sets the color of css files to blue
    "    let g:NERDTreeExtensionHighlightColor['css'] = s:blue
    "
    "    " this line is needed to avoid error
    "    let g:NERDTreeExactMatchHighlightColor = {}
    "
    "    " sets the color for .gitignore files
    "    let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange
    "
    "    " this line is needed to avoid error
    "    let g:NERDTreePatternMatchHighlightColor = {}
    "
    "    " sets the color for files ending with _spec.rb
    "    let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red
    "
        " let g:NERDTreeDirArrowExpandable = icon_expand
        " let g:NERDTreeDirArrowCollapsible = icon_expanded
    endif

    let g:NERDTreeIndicatorMapCustom = {
        \ 'Modified'  : icon_change,
        \ 'Staged'    : icon_add,
        \ 'Untracked' : icon_untrack,
        \ 'Renamed'   : icon_renamed,
        \ 'Unmerged'  : icon_unmerged,
        \ 'Deleted'   : icon_delete,
        \ 'Dirty'     : icon_dirty,
        \ 'Clean'     : icon_clean,
        \ 'Ignored'   : icon_ignored,
        \ 'Unknown'   : icon_unknow
        \}

    " toggle nerdtree display
    map <F3> :NERDTreeTabsToggle<CR>
    " open nerdtree with the current file selected
    nmap ,t :NERDTreeTabsFind<CR>

endif

""" Nerd Commenter 
"" See https://github.com/scrooloose/nerdcommenter

if (g:enable_nerdcommenter)
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1

    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1

    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'

    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1

    " Add your own custom formats or override the defaults
    "let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

    " Enable NERDCommenterToggle to check all selected lines is commented or not 
    let g:NERDToggleCheckAllLines = 1
endif

""" Tabman config
"" See https://github.com/kien/tabman.vim

if (g:enable_tabman ==1)
    let g:tabman_toggle = '<f2>'
    let g:tabman_side = 'rigth'
    let g:tabman_number = 0
endif

""" Air Line

if (g:enable_airline == 1)

    let g:airline_powerline_fonts = 0
    let g:airline_theme = 'bubblegum'
    let g:airline#extensions#whitespace#enabled = 0

    let g:airline#extensions#tagbar#enabled = 1

    let g:airline#extensions#ale#enabled = 1

    let g:airline#extensions#tmuxline#enabled = 0

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'

    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif

    if (g:patchedfont == 1)
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#left_sep = '⮀'
        let g:airline#extensions#tabline#left_alt_sep = '|'
        let g:airline_left_sep = '⮀'
        let g:airline_left_alt_sep = '⮁'
        let g:airline_right_sep = '⮂'
        let g:airline_right_alt_sep = '⮃'
        let g:airline_symbols.branch = '⭠'
        let g:airline_symbols.readonly = '⭤'
        let g:airline_symbols.linenr = '⭡'
    endif

    let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])

    if exists('PencilMode')
        let g:airline_section_x = '%{PencilMode()}'
    endif

endif

""" Tagbar
" See https://github.com/majutsushi/tagbar

if (g:enable_tagbar == 1)
    " toggle tagbar display
    map <F4> :TagbarToggle<CR>

    let g:tagbar_iconchars = [icon_expand, icon_expanded]


    " If you set this option the cursor will move to the Tagbar window when it is
    " opened.
    let g:tagbar_autofocus = 1

    " If you set this option the Tagbar window will automatically close when you
    " jump to a tag.
    "let g:tagbar_autoclose = 0

    " If this option is set the tags are sorted according to their name. If it is
    " unset they are sorted according to their order in the source file.
    "let g:tagbar_sort = 0

    " Whether line numbers should be shown in the Tagbar window.
    " Possible values are:
    "   0: Don't show any line numbers.
    "   1: Show absolute line numbers.
    "   2: Show relative line numbers.
    "  -1: Use the global line number settings.
    let g:tagbar_show_linenumbers = 1

    " If this variable is set to 1 then moving the cursor in the Tagbar window
    " will automatically show the current tag in the preview window.
    let g:tagbar_autopreview = 0
endif

""" vim-signify

" Update information
let g:signify_realtime = 1

" Enable line highlighting in addition to using signs by default.
let g:signify_line_highlight = 0

let g:signify_sign_add               = icon_add
let g:signify_sign_delete            = icon_delete
let g:signify_sign_delete_first_line = icon_delete_first_line
let g:signify_sign_change            = icon_change
let g:signify_sign_changedelete      = icon_change

" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

nmap <Leader>gg :SignifyToggleHighlight<CR>
nmap <Leader>gi :SignifyList<CR>
nmap <leader>gn <plug>(signify-next-hunk)
nmap <leader>gp <plug>(signify-prev-hunk)

""" ALE

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['stylelint', 'eslint'],
\}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Enable completion where available.
let g:ale_completion_enabled = 1

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" Keep the sign gutter open at all times
let g:ale_sign_column_always = 1

" Remove colors
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

" Lint on enter
let g:ale_lint_on_enter = 1

" enable/disabling highlighting
let g:ale_set_highlights = 1

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

"let g:ale_sign_error = icon_error
"let g:ale_sign_warning = icon_warning

"hi link ALEErrorSign    Error
"hi link ALEWarningSign  Warning

"hi link ALEError    Error
"hi link ALEWarning  Warning

let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

highlight clear ALEErrorSign
highlight clear ALEWarningSign

highlight ALEErrorSign ctermfg=9 ctermbg=15 guifg=#FF0500
highlight ALEWarningSign ctermfg=11 ctermbg=15 guifg=#ED6237

hi ALEError ctermfg=11 ctermbg=15 guifg=#EEEEEE guibg=#730500
" hi ALEWarning  Warning

let g:ale_echo_msg_error_str = icon_error
let g:ale_echo_msg_warning_str = icon_warning
let g:ale_echo_msg_format = '[%linter%] %severity% %s'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""" TaskList

" show pending tasks list
map <F12> :TaskList<CR>

""" Autoclose

let g:AutoClosePairs = "() [] {} \" ' ` <>"

""" YouCompleteMe

if (g:enable_ycm == 1)

    " This option controls the number of characters the user needs to type before
    " identifier-based completion suggestions are triggered. For example, if the
    " option is set to 2, then when the user types a second alphanumeric character
    " after a whitespace character, completion suggestions will be triggered. This
    " option is NOT used for semantic completion.
    "let g:ycm_min_num_of_chars_for_completion = 2

    " When set to 0, this option turns off YCM's identifier completer (the
    " as-you-type popup) and the semantic triggers (the popup you'd get after
    " typing . or -> in say C++). You can still force semantic completion with the
    " <C-Space> shortcut.
    "let g:ycm_auto_trigger = 1

    " This option controls the key mapping used to invoke the completion menu for
    " semantic completion. By default, semantic completion is trigged
    " automatically after typing ., -> and :: in insert mode (if semantic
    " completion support has been compiled in). This key mapping can be used to
    " trigger semantic completion anywhere. Useful for searching for top-level
    " functions and classes.
    "let g:ycm_key_invoke_completion = '<C-Space>'

    let g:ycm_filetype_blacklist = {
          \ 'tagbar' : 1,
          \ 'notes' : 1,
          \ 'markdown' : 1,
          \ 'text' : 1,
          \ 'vimwiki' : 1,
          \ 'pandoc' : 1,
          \ 'infolog' : 1,
          \ 'mail' : 1
          \}

    " When set, this option turns on YCM's diagnostic display features. See the
    " Diagnostic display section in the User Manual for more details.
    let g:ycm_show_diagnostics_ui = 1

    " When this option is set, YCM will put icons in Vim's gutter on lines that
    " have a diagnostic set. Turning this off will also turn off the YcmErrorLine
    " and YcmWarningLine highlighting.
    let g:ycm_enable_diagnostic_signs = 1

    " YCM will use the value of this option as the symbol for errors in the Vim
    " gutter.
    "let g:ycm_error_symbol = '>>'

    " YCM will use the value of this option as the symbol for warnings in the Vim
    " gutter.
    "let g:ycm_warning_symbol = '>>'

    let g:ycm_error_symbol = icon_error
    let g:ycm_warning_symbol = icon_warning

    " When this option is set, YCM will highlight regions of text that are related
    " to the diagnostic that is present on a line, if any.
    let g:ycm_enable_diagnostic_highlighting = 1

    " When this option is set, YCM will echo the text of the diagnostic present on
    " the current line when you move your cursor to that line. If a FixIt is
    " available for the current diagnostic, then (FixIt) is appended.
    let g:ycm_echo_current_diagnostic = 1

    " When this option is set to 1, YCM will show the completion menu even when
    " typing inside comments.
    let g:ycm_complete_in_comments = 1

    " When this option is set to 1, YCM will show the completion menu even when
    " typing inside strings.
    let g:ycm_complete_in_strings = 1

    " When this option is set to 1, YCM's identifier completer will also collect
    " identifiers from strings and comments. Otherwise, the text in comments and
    " strings will be ignored.
    let g:ycm_collect_identifiers_from_comments_and_strings = 0

    " When this option is set to 1, YCM's identifier completer will also collect
    " identifiers from tags files. The list of tags files to examine is retrieved
    " from the tagfiles() Vim function which examines the tags Vim option. See :h
    " 'tags' for details.
    let g:ycm_collect_identifiers_from_tags_files = 1

    " This option controls the key mappings used to select the first completion
    " string. Invoking any of them repeatedly cycles forward through the
    " completion list.
    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

endif

""" Snippets (ultisnips)

if (g:enable_ultisnips == 1)
    " Trigger configuration. Do not use <tab> if you use
    " https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger = "<c-space>"
    let g:UltiSnipsListSnippets = "<c-s-tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

    " let g:UltiSnipsSnippetsDir = "~/.vim/plugged/vim-snippets/snippets"
    " let g:UltiSnipsSnippetDirectories=['UltiSnips', 'mysnippets']
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    function! s:lookForSnippets()
        let l:path = ProjectRootGuess() . "/snippets"
        if isdirectory(l:path)
            let g:UltiSnipsSnippetDirectories = [l:path]
            " for file in split(glob(l:spath), '\n')
            "     g:UltiSnipsSnippetDirectories =
            " endfor
        endif
    endfunction

    autocmd! BufReadPost,BufNewFile * call s:lookForSnippets()

endif

""" Markdown
" https://github.com/plasticboy/vim-markdown

let g:markdown_fenced_languages = ['javascript']

""" vim-pencil
" See https://github.com/reedes/vim-pencil


let g:pencil#wrapModeDefault = 'hard'
let g:pencil#autoformat = 1
let g:pencil#textwidth = 79


" Disable Default Key Mappings
let g:vim_markdown_no_default_key_mappings = 1


""" Tabular
" See https://github.com/godlygeek/tabular

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

""" vim-jsdocs

"Allow prompt for interactive input.
let g:jsdoc_allow_input_prompt = 1

" Prompt for a function description
let g:jsdoc_input_description = 1

" Set value to 1 to turn on detecting underscore starting functions as private
" convention
let g:jsdoc_underscore_private = 1

" Enable to use ECMAScript6's Shorthand function, Arrow function.
let g:jsdoc_enable_es6 = 1

" Allow use of user_defined_tags
let g:jsdoc_user_defined_tags = {}

""" vim-jsx

let g:jsx_ext_required = 0

""" isort
" See https://github.com/fisadev/vim-isort

let g:vim_isort_map = '<leader>s'

" You can also specify a particular Python version, so if isort is installed
" under Python 3:
"let g:vim_isort_python_version = 'python3'

""" Previm

let g:previm_open_cmd = "sensible-browser"

""" Specific lang config

"" Text/Markdown

"autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"autocmd BufNewFile,BufReadPost *.mkd set filetype=markdown
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd FileType markdown call pencil#init()
autocmd FileType markdown setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType markdown let g:AutoClosePairs_add = "* _ ~"
autocmd FileType markdown inoremap <silent> <Bar>   <Bar><Esc>:call <SID>alignMarkdownTable()<CR>a

"" HTML
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html,css,vue,jsx EmmetInstall

"" Python

if (g:lang_python == 1)
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango let b:surround_45 = "{{ \r }}"
endif

"" Ruby
if (g:lang_ruby == 1)
    autocmd FileType ruby let g:AutoClosePairs_add = "|"
    autocmd FileType ruby UltiSnipsAddFiletypes ruby
endif

"" JavaScript && Node.js
if (g:lang_javascript == 1)
    autocmd FileType pug setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript let b:surround_45 = "${\r}"
    autocmd FileType javascript map ys` cs"`cs'`
    autocmd FileType javascript nmap <C-l> <Plug>(jsdoc)
    " autocmd FileType javascript UltiSnipsAddFiletypes javascript-jasmine

    if (g:enable_syntastic == 1)
        autocmd FileType javascript let g:syntastic_javascript_checkers =
          \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
          \ HasConfig('.eslintrc.json', expand('<amatch>:h')) ? ['eslint'] :
          \ HasConfig('.eslintrc.js', expand('<amatch>:h')) ? ['eslint'] :
          \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
          \ executable("eslint") ? ['eslint'] :
          \ executable("jshint") ? ['jshint'] :
          \     ['standard']
    endif

    if (g:enable_ale == 1)
        augroup FiletypeGroup
            autocmd!
            au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
        augroup END

        " let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
        let g:ale_linter_aliases = {'jsx': 'css'}
    endif


    autocmd FileType javascript UltiSnipsAddFiletypes javascript
    autocmd FileType javascript UltiSnipsAddFiletypes javascript-mocha
    autocmd FileType javascript UltiSnipsAddFiletypes javascript.es6.react

    autocmd FileType javascript nmap <leader>'' cs"'
    autocmd FileType javascript nmap <leader>"" cs'"
endif
