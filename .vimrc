set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes' "https://github.com/vim-airline/vim-airline/wiki/Dummies-Guide-to-the-status-bar-symbols-(Powerline-fonts)-on-Fedora,-Ubuntu-and-Windows
" sudo apt-get install fonts-powerline
Plugin 'VundleVim/Vundle.vim'
Plugin 'mbbill/undotree'
Plugin 'airblade/vim-rooter'
Plugin 'kana/vim-arpeggio'
Plugin 'universal-ctags/ctags'
Plugin 'kana/vim-textobj-user'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'thaerkh/vim-workspace'
Plugin 'jnurmine/Zenburn'
Plugin 'easymotion/vim-easymotion'
Plugin 'ekalinin/Dockerfile.vim'
call vundle#end()            " required
filetype plugin indent on    " required



"fzf
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>c :Commands<CR>
nmap <leader>h :History<CR>
nmap <leader>m :Marks<CR>
nmap <leader>s :Rg

" Color Scheme
colorscheme zenburn

" vim-workspace
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_session_directory = $HOME . '/.vim/sessions/'


set undofile
set undodir=$HOME/.vim/undo
set mouse=a

set nocompatible
set undolevels=1000
set undoreload=10000
set autowrite
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=79
highlight OverLength ctermbg=53
match OverLength /\%81v.*/
set expandtab
set autoindent
set fileformat=unix
set cursorcolumn
set cursorline
set showmatch
set shortmess=a
set cmdheight=1
set clipboard=unnamedplus
set list listchars=trail:•
set autoread
set scrolloff=3
set incsearch
set hlsearch
set number relativenumber
let s:python_version = 3
filetype plugin on

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"nerdtree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"disabilita highlight quando entra in InsertMode
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>



"Funzione custom per muovere il cursore a n jump precedenti
"https://vim.fandom.com/wiki/Jumping_to_previously_visited_location
function! GoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction


noremap <leader>j :call GoJump()<CR>


function! UsePasteReg()
  reg
  let j = input("Paste register: ")
  if j != ''
      execute "normal \"" . j . "p\<CR>"
  endif
endfunction
"Arpeggio bindings
packadd vim-arpeggio
Arpeggio nmap gf <Esc>:Files<CR>
Arpeggio nmap gh <Esc>:History<CR>
Arpeggio nmap gb <Esc>:Buffers<CR>
Arpeggio nmap gc <Esc>:Commands<CR>
Arpeggio nmap gm <Esc>:Marks<CR>
Arpeggio nmap gs <Esc>:Rg
Arpeggio nmap gs <Esc>:Rg
Arpeggio nmap ut <Esc>:UndotreeToggle<CR>
Arpeggio nmap gp <Esc>:call UsePasteReg()<CR>
Arpeggio noremap gj <Esc>:call GoJump()<CR>
Arpeggio inoremap jk <Esc>
Arpeggio map tr <Esc>:NERDTreeToggle<CR>



"statusline
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='zenburn'
