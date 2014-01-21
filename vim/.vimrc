" http://vimdoc.sourceforge.net/htmldoc/starting.html#vimrc
" run pathogen
call pathogen#infect()

filetype plugin on

set fileencodings=utf-8,latin2
set enc=utf-8
set relativenumber 	

set wildmenu
set wildmode=list:longest " make completion behave like in bash

set autochdir
set backupdir=/tmp,d:\vim-backups
set noswapfile

set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" hilight line and column
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

set nocompatible        " use vim defaults
set scrolloff=7         " keep 7 lines when scrolling
set ai                  " set auto-indenting on for programming

set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file
set ruler               " show the current row and column
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present
set gdefault            " replace all occurences by default

set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell

set backspace=indent,eol,start  " make that backspace key work the way it should

syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file
filetype indent on      " load indent file for specific file type

set t_RV=               " http://bugs.debian.org/608242, http://groups.google.com/group/vim_dev/browse_thread/thread/9770ea844cec3282

set laststatus=2        " always show the status line
" buffer number / full filename / {endline type | encoding / filetype}  [line,col][percent]
set statusline=\ %n\ \ %<%F%m%r%h%w\ %=%(%{&ff}\ \|\ %{(&fenc==\"\"?&enc:&fenc)}%k\ \|\ %Y%)\ %([%l,%v][%p%%]\ %)

"  parts from http://amix.dk/vim/vimrc.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w<cr>

" close tab
map <leader>c :tabclose<cr>
" quickly close all if nothing waits for saving
map <leader>q :qa<cr>

" Quickly open a buffer for scribble
map <leader>e :tabe ~/buffer<cr>

" Insert in paste mode
set pastetoggle=<F2>

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" Exit insert mode faster
inoremap jk <ESC>

" ; instead of shift+;
nnoremap ; :

" kill hilights
nmap <silent> ,/ :nohlsearch<CR>

" yank the word under the cursor into status line for search/replace
map <leader>s :%s/<C-r><C-w>/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tab shortcuts
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

" Switch between tabs with ctrl+H|L
nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>
" Move tabs with alt + j|k
nnoremap <silent> <C-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-k> :execute 'silent! tabmove ' . tabpagenr()<CR>

" show tab number on tabline
if has('gui')
  set guioptions-=e
endif
if exists("+showtabline")
  function MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      let s .= '%' . i . 'T'
      let s .= (i == t ? '%1*' : '%2*')
      let s .= ' '
      let s .= i . ':'
      "let s .= winnr . '/' . tabpagewinnr(i,'$')
      let s .= '%*'
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')
      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif
      if file == ''
        let file = '[No Name]'
      endif
      let s .= file
      let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
  endfunction
  set stal=2
  set tabline=%!MyTabLine()
endif

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" setup for the visual environment
if has('gui_running')
        if (match(system("uname -s"), "Darwin") != -1)
            set lines=999
            set columns=999 "fix shitty maximization in macvim
        else
            au GUIEnter * simalt ~x "open maximised
        endif
        set guioptions=   "remove menu bar, toolbar, scrollbars
        set guioptions+=c   "console dialogs
else
        if $TERM =~ '^xterm'
                set t_Co=256 
        elseif $TERM =~ '^screen-bce'
                set t_Co=256            " just guessing
        elseif $TERM =~ '^rxvt'
                set t_Co=88
        elseif $TERM =~ '^linux'
                set t_Co=8
        else
                set t_Co=16
        endif
endif

try
    colo zenburn
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
    colo torte
endtry

" don't open folds on search
set fdo-=search

"split window navigation shift+hjkl
nnoremap <silent> <S-k> :wincmd k<CR>
nnoremap <silent> <S-j> :wincmd j<CR>
nnoremap <silent> <S-h> :wincmd h<CR>:vertical resize 85<CR>
nnoremap <silent> <S-l> :wincmd l<CR>:vertical resize 85<CR>

" shift+J is now shift+U
nnoremap <S-u> :join<CR>

" color 80 column
if exists('+colorcolumn')
    set colorcolumn=81
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif

"n/p quickfix
nnoremap <c-n> :cnext<CR>
nnoremap <c-m> :cprevious<CR>

" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.cmo,*.cmi,*.cmx,*.a,*.annot
set wildignore+=*.cmxa
" Windows
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  

" :R dir<CR> will open a scratch buffer with dir output
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" different makes for different OSes
if has("win32")
  set makeprg=mingw32-make
else
  set makeprg=make
endif

" save and make
nnoremap <leader>m :w<CR>:make<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" , instead of <leader><leader>
let g:EasyMotion_leader_key = ','
" ocaml comments for commentary.vim
autocmd FileType ocaml set commentstring=(*\ %s\ *)
