set nocompatible        "Turn off vi compatibility

""" Vim-Plug section

" Autoinstall Vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins section
call plug#begin()

Plug 'ntpeters/vim-better-whitespace'       "Show tralling whitespaces
Plug 'mhinz/vim-signify'                    "Show diffs in-file
Plug 'vim-syntastic/syntastic'              "Syntax checker for all
"Plug 'sheerun/vim-polyglot'                "Syntax highlighting for all
Plug 'thinca/vim-quickrun'                  "Run script currently from VIM
Plug 'itchyny/lightline.vim'                "Another status line
Plug 'elzr/vim-json'                        "Better JSON file highlight
Plug 'ajh17/VimCompletesMe'                 "another autocomplete
Plug 'nathanaelkane/vim-indent-guides'      "Show lines at indentation (with <leader>ig)
Plug 'ludovicchabant/vim-gutentags'         "Autotags
Plug 'vimwiki/vimwiki'                      "Make wiki in vim

"Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()                           "Required (end of init)

""" End of Vim-Plug section

""" Plugin specific
let g:better_whitespace_enabled=1           "Enable plugin
let g:strip_whitespace_on_save=1            "Strip on save

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ["python2", "flake8"]
let g:syntastic_python_flake8_post_args='--ignore=E501,E402,F401'
"end_syntastic

let g:vim_json_syntax_conceal = 0           "Do not hide quotes in json files. Used with elzr/vim-json pluggin

let g:lightline = { 'colorscheme': 'seoul256' }

"let g:jedi#popup_on_dot = 0                 "Do not pop up completion when dot(.) appears. Use Ctrl+Space instead
"let g:jedi#use_splits_not_buffers = "right" "Use splits instead of buffers
"let g:jedi#show_call_signatures = "2"       "Show signs in command line

set statusline+=%{gutentags#statusline('[Generating...]')}

let g:gutentags_project_root = ['.svn']

let g:vimwiki_list = [{'path_html': '/var/www/list/vimwiki/'}]

" Proper colors for vim-indent_guides plugins
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#303030   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3a3a3a   ctermbg=237

" Disable some defaults plugins
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_vimballPlugin = 1

"set timeoutlen=1000                         "Do not delay exit from INSERT

""" END of Plgin specific

" 256 color term tweaks
let s:colorful_term=(&term=~"xterm") || (&term=~"screen")
if s:colorful_term
    " 256 color -- this is a bad idea generally, but I use it anyway
    let &t_Co=256
    " don't clear background color
    set t_ut=
    " restore screen after quitting
    if has("terminfo")
        let &t_Sb="\ESC[4%p1%dm"
        let &t_Sf="\ESC[3%p1%dm"
    else
        let &t_Sb="\ESC[4%dm"
        let &t_Sf="\ESC[3%dm"
    endif
endif


" Searching
set smartcase                               "Try to be smarter about cases
set showmatch                               "Show matching brackets when cursor on one of them
set hlsearch                                "Highlight search results
set nohlsearch                              "Turn off hlsearch, when we exit searching mode
set incsearch                               "Move to 1st match immediately, while typing
set magic                                   "Always enable magic for regex
set ignorecase                              "Ignore case when searching

" View
set number                                  "Enable numbering lines
set showmode                                "Always show mode
set background=dark                         "If we have black background in terminal
"set t_Co=256                               "Use 256 colors for vim-airline
colorscheme nofrils-dark                    "Use nice colorscheme
set cursorline                              "Current line highlight
set colorcolumn=120                         "Red line on 120 coloumn
set ruler                                   "Always show current position
set laststatus=2                            "Always show status line
set visualbell                              "Use visual bell instead of beeping when something wrong
set wildmenu                                "Enable wildmenu. It's realy wild.
set showcmd                                 "Show entered symbols
"set list lcs=tab:\|\                        "Mark tabulated indents

""" Hardcore wrapping lines
set nowrap                                    "Enable wrap lines
set textwidth=0                             "Preventing Vim from automatically inserting line breaks (<CR>)
set wrapmargin=0                            "Also need for preventing Vim from automatically inserting line breaks
set linebreak                               "Drop whole word to new line, but not by character
set nolist                                  "Because 'list' disables linebreak
set showbreak=>\                            "Show where line is broken

" Encoding
set encoding=utf-8                          "Default encoding
set termencoding=utf-8                      "Default terminal encoding
set fileencodings=utf-8,cp1251,koi8-r       "Try to open file in this encodings

" History
set undolevels=1024                         "How much undo levels should vim remember
set history=256                             "Sets how many lines of history VIM has to remember

set tabstop=4                               "Change tabs by four spaces.
set softtabstop=4                           "Change tabs by four spaces.
set shiftwidth=4                            "Move the string by four symbols on string shifting.
"set textwidth=119
set expandtab                               "Always change tabs into spaces.
set autoindent                              "Make auto indent (Cap here)
set fileformat=unix
set hidden                                  "Switch between buffers without having to save first.

"au BufNewFile,BufRead *.js, *.html, *.css
"    \ set tabstop=2
"    \ set softtabstop=2
"    \ set shiftwidth=2

" Experimental
"set smarttab                                "Analyse indents in doc and do same shit
set shellslash                              "Change backslash to slash in paths. Because backslash sucks.
set scrolloff=7                             "When the page starts to scroll, keep the cursor 7 lines from the top and bottom."
set foldmethod=indent                       "Fold by indents (for Python)
set foldlevelstart=99                       "Do not autofold on fileopen
set foldlevel=99                            "Do not autofold on fileopen
set pastetoggle=<F2>
set clipboard+=unnamedplus

""" Mapping

" Write file if I forget to open ir with sudo
nmap <F3> :w !sudo tee % >/dev/null<CR><CR>

" Toggle line numbers
nmap <F4> :set invnumber<CR>

" Buffers => tabs
nmap <F5> :tab sball <CR>

" Open nerdtree with Ctrl+n
nmap <C-n> :NERDTree<CR>

" Start FZF
nmap <C-p> :FZF<CR>

" Because I'm tired to write ! symbol
cmap q  q!

" Enabling hardcore mode in normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>


" Smarter Cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" RU Keyboard mapping
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

""" END of Mapping
