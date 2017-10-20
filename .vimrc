set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'qpkorr/vim-bufkill'
Plugin 'dbakker/vim-projectroot'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" NerdTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"highlighting
let python_highlight_all=1
syntax on

" Color Scheme
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

" Line numbering
set nu

" ctrl P
set wildignore+=*/__pycache__/*,*.py[cod],*.class
set wildignore+=*/.Python/*,*/env/*,*/build/*,*/develop-eggs/*,*/dist/*,*/downloads/*,*/eggs/*,*/.eggs/*,*/lib/*,*/lib64/*,*/parts/*,*/sdist/*,*/var/*,*/wheels/*,*/.idea/*,*.egg-info/*,*/.installed.cfg*,*.egg/*
set wildignore+=*.manifest,*.spec

" Use the 'wildignore' and 'suffixes' settings for filtering out files.
function! s:FileGlobToRegexp( glob )
" The matching is done against the sole file / directory name.
  if a:glob =~# '^\*\.'
     return '\.' . a:glob[2:] . '$'
  else
     return '^' . a:glob . '$'
  endif
endfunction
let g:NERDTreeIgnore =  map(split(&wildignore, ','),'s:FileGlobToRegexp(v:val)') 
delfunction s:FileGlobToRegexp


" tabline

let g:airline#extensions#tabline#enabled = 1
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

" Indentation
au BufNewFile,BufRead *.py |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ autocmd vimenter * NERDTree |
    \ autocmd BufEnter * call<SID>AutoProjectRootCD() |
    \ autocmd VimEnter * wincmd p |

set cursorline
set showmatch

let g:auto_save = 1  " enable AutoSave on Vim startup

map <C-c> :BD<cr> " kill buffer with ctrl - c

set shortmess=a
set cmdheight=2
