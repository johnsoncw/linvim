set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Plugin 'scrooloose/syntastic'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'SirVer/ultisnips'
Plugin 'rking/ag.vim'
call vundle#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/bbye
set runtimepath^=~/.vim/bundle/vim-dispatch

filetype plugin indent on

inoremap kj <ESC>
let g:solarized_termcolors=256
syntax on
set encoding=utf-8
set background=light
colorscheme solarized
set number
set gfn=Droid\ Sans\ Mono\ 10

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-s-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
let g:ycm_key_list_previous_completion=['<Up>']

" /@ search clears search pattern
let @/ = ""

set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
set incsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
set shiftwidth=4
set tabstop=4

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
nmap <SPACE> <SPACE>:noh<CR>
nmap <C-n> :NERDTreeTabsToggle<CR>

" allow vim to close if just NERDTree is active
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

:set listchars=eol:$,tab:>>,trail:+,extends:>,precedes:<

if has("autocmd")
    " xfce4 terminal
    au InsertEnter * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_IBEAM/' ~/.config/xfce4/terminal/terminalrc"
    au InsertLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
    au VimLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_IBEAM/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/xfce4/terminal/terminalrc"
    " xterm:
    " let &t_SI = "\<Esc>[6 q"
    " let &t_SR = "\<Esc>[4 q"
    " let &t_EI = "\<Esc>[2 q"
    " 1 or 0 -> blinking block
    " 2      -> solid block
    " 3      -> blinking underscore
    " 4      -> underscore
    " Recent xterm (>= 282)
    " 5      -> blinking vertical bar
    " 6      -> solid vertical bar
endif

" let &t_ti.="\e[?7727h"
" let &t_te.="\e[?7727l"
" noremap <Esc>O[ <Esc>
" noremap! <Esc>O[ <C-c>
" 
" syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

nmap <C-Down> ddp
nmap <C-Up> ddkP
nmap <C-j> 2jzz
nmap <C-k> 2kzz

if &term =~ '256color'
    "disable Backkground Color Erase for correct backgound in tmux
    set t_ut=
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  set grepformat=%f:%l:%c%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

set wildignore+=*/tmp/*,*.so,*.su,*.swp,*.zip

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nmap <kPlus> <C-w>+
nmap <kMinus> <C-w>-
nmap <kDivide> <C-w><
nmap <kMultiply> <C-w>>

let mapleader = ","

map <leader>r :NERDTreeTabsFind<cr>
nmap <leader>f <Plug>ShowFunc
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>H :sp<CR>
nmap <leader>V :vs<CR>
nmap <leader>d :q<CR>
nmap <leader>c :tabe<CR>
nmap <leader>q :Bdelete<CR>
nmap <leader>m :Make -ws 
nmap <leader>M :Make! -ws 
nmap <leader>w :set list<CR>
nmap <leader>n :set nolist<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>

nmap tn :tabnext<CR>
nmap tp :tabprev<CR>
nmap tt :tabfirst<CR>
nmap cn :cnext<CR>
nmap cp :cprevious<CR>

set makeprg=dabchroot\ make

hi User1 ctermfg=red ctermbg=grey

" status line
set laststatus=2
set statusline=
set statusline+=\ %n\     " buffer num
set statusline+=%1*%m%*   " modified
set statusline+=\ %<%F\   " path
set statusline+=%y        " file type
set statusline+=%=(%l,%v)\ %p%%[%L]   " row/col tot-percent

