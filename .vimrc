set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'qpkorr/vim-bufkill'
Plugin 'tell-k/vim-autopep8'
Plugin 'dbakker/vim-projectroot'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tweekmonster/impsort.vim'
Plugin 'ap/vim-buftabline'
Plugin 'tpope/vim-fugitive'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()            " required
filetype plugin indent on    " required

" NerdTree
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
set wildignore+=*__pycache__*,*.py[cod],*.class
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
let g:NERDTreeIgnore += ['.*__pycache__.*', '.*/\.Python.*', '.*/env.*','.*build.*', '.*\.egg.*', '.*dist.*' ]


" Autocomplete
let g:ycm_autoclose_preview_window_after_completion=1


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
    \ set cmdheight=1 |
    \ au VimEnter *.py NERDTree | wincmd p
autocmd BufEnter * call<SID>AutoProjectRootCD() |
autocmd BufWritePre *.py ImpSort! 

"let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_in_insert_mode = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1  

set cursorcolumn
set cursorline
set showmatch
set shortmess=a
set cmdheight=2

" kill buffer with ctrl-c
map <C-c> :BD<cr> 

map <F5> :call VimuxRunCommand("clear; python " . expand("%:p"))<CR>
map <F6> :call VimuxRunCommand("clear; python -m unittest")<CR> 
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR> 
map <Leader>vz :VimuxZoomRunner<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <F3> :NERDTreeToggle<CR> 
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>  
" Go to next tab
nnoremap <Tab> :bnext<CR>  
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
