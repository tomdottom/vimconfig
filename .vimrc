set nocompatible                    " not compatible with legacy vi
set shortmess+=|                    " Disable splash screen

" Use utf 8 encoding
set encoding=utf-8

" turns tabs into spaces and sets 4 spaces to a tab
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set nowrap

" turns off swap files and backups
set nobackup
set nowb
set noswapfile

set ruler
set t_Co=256

if has("gui_running")
    set guioptions-=T  "remove toolbar
    set guioptions+=e  "remove toolbar
    set guifont=Ubuntu\ Mono\ 13
    colorscheme calmar256-dark
elseif !empty($PYTHONANYWHERE)
    colorscheme delek
    set t_Co=8
else
    colorscheme molokai
endif

inoremap <Nul> <C-p>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" ctags ahoy
let Tlist_Ctags_Cmd = "/usr/bin/ctags -R -o ~/.mytags"
let Tlist_WinWidth = 50
map <F12> :TlistToggle<cr>

set tags=~/.mytags

" Strips trailing whitespace when saving Python & RST files
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.rst :%s/\s\+$//e

syntax on
filetype plugin indent on
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=80 " PEP-8 Friendly

set ffs=unix,dos
"make sure highlighting works all the way down long files
autocmd BufEnter * :syntax sync fromstart

" allow cursor to be positioned one char past end of line
" and apply operations to all of selection including last char
set selection=exclusive

" allow backgrounding buffers without writing them
" and remember marks/undo for backgrounded buffers
set hidden

" ============================== Scrolling ===================================
" Keep more context when scrolling off the end of a buffer
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" allow cursor keys to go right off end of one line, onto start of next
set whichwrap+=<,>,[,]
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase
" show search matches as the search pattern is typed
set incsearch
" search-next wraps back to start of file
set wrapscan
" highlight last search matches
set hlsearch
" map key to dismiss search highlightedness
map <bs> :noh<CR>


set showcmd         " Shows commands as you build them
set showmode        " Shows current mode in status bar

" allows clicking links
set mouse=a

" Stops vim beeping at you, flashes the screen instead
set visualbell

" Put a line on the 80 character marker
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

set cursorline
set history=1000
set number

" Makes tab complete work more like the shell
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc

filetype indent on
filetype on
filetype plugin on

let mapleader = ","

" CtrlP stuff
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <Leader>f :CtrlP <CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" DONTify and unDONTify test names
map <F7> :%s/def test/def DONTtest/g<CR>
map <F8> :%s/def DONTtest/def test/g<CR>
nnoremap <Leader>d :%s/def test/def DONTtest/<CR>
nnoremap <Leader>D :%s/def DONTtest/def test/<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

map <F1> :bprevious<CR>
map <F2> :bnext<CR>

" Insert time and date at the top of the file, useful for journals
nmap <F6> ggO<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><CR>-----------------------<CR>
imap <F6> <Esc>ggO<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><CR>-----------------------<CR>


" =====STATUS LINE OF DEATH!!=====
set statusline=
" filename, relative to cwd
set statusline+=%f
" separator
set statusline+=\ 

" modified flag
set statusline+=%#wildmenu#
set statusline+=%m
set statusline+=%*

"Display a warning if file encoding isnt utf-8
set statusline+=%#question#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

"display a warning if fileformat isnt unix
set statusline+=%#directory#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if files contains tab chars
set statusline+=%#warningmsg#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

" read-only
set statusline+=%r
set statusline+=%*

" right-align
set statusline+=%=

" filetype
set statusline+=%{strlen(&ft)?&ft:'none'}
" separator
set statusline+=\ 

" current char
set statusline+=%3b,0x%02B
" separator
set statusline+=\ 

" column,
set statusline+=%2c,
" current line / lines in file
set statusline+=%l/%L

" always show status line
set laststatus=2

" return '[tabs]' if tab chars in file, or empty string
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0

        if tabs
            let b:statusline_tab_warning = '[tabs]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction
"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Some common typing errors
abbr hte the
abbr Hasnel Hansel

" Stop pyflakes overwriting my quickfix list every time!!!!
let g:pyflakes_use_quickfix = 0
