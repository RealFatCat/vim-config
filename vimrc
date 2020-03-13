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
Plug 'itchyny/lightline.vim'                "Another status line
Plug 'elzr/vim-json'                        "Better JSON file highlight
Plug 'nathanaelkane/vim-indent-guides'      "Show lines at indentation (with <leader>ig)
Plug 'dense-analysis/ale'                   "ALE (Asynchronous Lint Engine)
Plug 'fatih/vim-go'                         "Golang vim plug

"Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

call plug#end()                           "Required (end of init)

""" End of Vim-Plug section

""" Plugin specific
let g:better_whitespace_enabled=1

"" vim-go specific

let g:go_autodetect_gopath = 1

" move around errors
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

" GoBuild shortcut
autocmd FileType go nmap <leader>b  <Plug>(go-build)

" Show info about function info
let g:go_auto_type_info = 1

"" end of vim-go specific

let g:vim_json_syntax_conceal = 0           "Do not hide quotes in json files. Used with elzr/vim-json pluggin

let g:lightline = { 'colorscheme': 'seoul256' }

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

set bs=2

" Searching
set smartcase                               "Try to be smarter about cases
set showmatch                               "Show matching brackets when cursor on one of them
set hlsearch                                "Highlight search results
set nohlsearch                              "Turn off hlsearch, when we exit searching mode
set incsearch                               "Move to 1st match immediately, while typing
set magic                                   "Always enable magic for regex
set ignorecase                              "Ignore case when searching

" View
set ttyfast                                 "Faster redrawing
set lazyredraw                              "redraw only when needed
set number                                  "Enable numbering lines
set showmode                                "Always show mode
set background=dark                         "If we have black background in terminal
colorscheme nofrils-dark                    "Use nice colorscheme
set cursorline                              "Current line highlight
set colorcolumn=120                         "Line on 120 coloumn
set ruler                                   "Always show current position
set laststatus=2                            "Always show status line
set visualbell                              "Use visual bell instead of beeping when something wrong
set wildmenu                                "Enable wildmenu. It's realy wild.
set showcmd                                 "Show entered symbols
set autoread                                "Auto read changed files
set noshowmode                              "We show mode via lightline

set nowrap                                  "Disable wrap lines

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
set expandtab                               "Always change tabs into spaces.
set autoindent                              "Make auto indent (Cap here)
set fileformat=unix
set hidden                                  "Switch between buffers without having to save first.


" Experimental
set shellslash                              "Change backslash to slash in paths. Because backslash sucks.
set scrolloff=7                             "When the page starts to scroll, keep the cursor 7 lines from the top and bottom."
set foldmethod=indent                       "Fold by indents (for Python)
set foldlevelstart=99                       "Do not autofold on fileopen
set foldlevel=99                            "Do not autofold on fileopen
set pastetoggle=<F2>
set autowrite                               "Save before :make

" Enable copy to clipboard for operations like yank, delete, change and put
if has('unnamedplus')
  set clipboard^=unnamed
  set clipboard^=unnamedplus
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/tmp/undo/
endif

""" Mapping

" Write file if I forget to open ir with sudo
nmap <F3> :w !sudo tee % >/dev/null<CR><CR>

" Toggle line numbers
nmap <F4> :set invnumber<CR>

" Buffers => tabs
nmap <F5> :tab sball <CR>

" Start FZF
nmap <C-p> :FZF<CR>

" Enabling hardcore mode in normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

map <leader>gf :tabe <cfile><cr>

" Smarter Cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
