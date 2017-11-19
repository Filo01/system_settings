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
"Plugin 'vim-scripts/vim-auto-save'
Plugin 'qpkorr/vim-bufkill'
Plugin 'tell-k/vim-autopep8'
Plugin 'dbakker/vim-projectroot'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tweekmonster/impsort.vim'
"Plugin 'ap/vim-buftabline'
Plugin 'tpope/vim-fugitive'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-commentary'
Plugin 'justinmk/vim-sneak'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mattn/emmet-vim'
call vundle#end()            " required

filetype plugin indent on    " required

" NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline
set laststatus=2
"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='simple'
"let g:airline_highlighting_cache = 0
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
        let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '>'
let g:airline_right_sep = '«'
let g:airline_right_sep = '<'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


"  let g:airline_right_alt_sep = ''0
"  let g:airline_right_sep = ''
"  let g:airline_left_alt_sep= ''
"  let g:airline_left_sep = ''

"highlighting
let python_highlight_all=1
syntax on

" Color Scheme
colorscheme zenburn


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

" Sneak
let g:sneak#label = 1

" Autocomplete
let g:ycm_autoclose_preview_window_after_completion=1

" Folding
let g:SimpylFold_docstring_preview = 1

function! <SID>AutoProjectRootCD()
  try
    if &ft != 'help'
      ProjectRootCD
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

au VimEnter *.py NERDTree | wincmd p

"expand all folds on opening
au BufNewFile,BufRead *.py normal zR
autocmd VimEnter * call<SID>AutoProjectRootCD() |
autocmd BufWritePre *.py silent! ImpSort!
autocmd FileType python set omnifunc=python3complete#Complete
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq =  0
let g:syntastic_mode_map = {"mode":"passive", "active_filetypes":[],"passive_filetypes":["python"]}
"let g:syntastic_quiet_messages = { "level": "warnings" }
"let g:syntastic_python_pylint_quiet_messages = { "level" : ["warnings"] }
let b:syntastic_python_pylint_sort = 0

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
set splitright
set list listchars=trail:•
set autoread
set scrolloff=3
set incsearch
set hlsearch
set number relativenumber
let s:python_version = 3
filetype plugin on
" kill buffer with ctrl-c
map <C-c> :BD<cr>

map <F4> :w<CR>:SyntasticCheck<CR>:Errors<CR>
map <F5> :call VimuxRunCommand("clear; python " . expand("%:p"))<CR>
map <F6> :call VimuxRunCommand("clear; python -m unittest")<CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vz :VimuxZoomRunner<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <F3> :NERDTreeToggle<CR>
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap \\ :nohl<CR>
" Go to next tab
nnoremap <Tab> :w<CR>:CtrlPBuffer<CR>
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
