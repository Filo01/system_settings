filetype off                  " required
set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')
Plug 'skywind3000/asyncrun.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-python'
Plug 'ryanolsonx/vim-lsp-typescript' "sudo npm install -g typescript typescript-language-server
Plug 'ryanolsonx/vim-lsp-javascript'
Plug 'mattn/emmet-vim'
Plug 'pedsm/sprint'
Plug 'junegunn/vim-peekaboo'
Plug 'rickhowe/diffchar.vim'
Plug 'will133/vim-dirdiff'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'idanarye/vim-merginal'
"Plug 'Chiel92/vim-autoformat'
"Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-fugitive'
Plug 'milkypostman/vim-togglelist'
Plug 'yggdroot/indentline'
"Plug 'w0rp/ale'
Plug 'szw/vim-maximizer'
"Plug 'vim-syntastic/syntastic'
Plug 'moll/vim-bbye'
Plug 'diepm/vim-rest-console'
Plug 'vim-scripts/indentpython.vim'
Plug 'sheerun/vim-polyglot' "syntax highlight
Plug 'tmhedberg/SimpylFold'
Plug 'plytophogy/vim-virtualenv'
"Plug 'davidhalter/jedi-vim'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'vim-scripts/cscope.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'bkad/camelcasemotion'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'vim-airline/vim-airline' " sudo apt-get install fonts-powerline
Plug 'vim-airline/vim-airline-themes' "https://github.com/vim-airline/vim-airline/wiki/Dummies-Guide-to-the-status-bar-symbols-(Powerline-fonts)-on-Fedora,-Ubuntu-and-Windows
Plug 'VundleVim/Vundle.vim'
Plug 'mbbill/undotree'
Plug 'airblade/vim-rooter'
Plug 'kana/vim-arpeggio'
Plug 'kana/vim-textobj-user'
Plug 'matchit.zip'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'thaerkh/vim-workspace'
Plug 'jnurmine/Zenburn'
Plug 'tomasiser/vim-code-dark'
Plug 'ekalinin/Dockerfile.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'ryanoasis/vim-devicons' "https://github.com/ryanoasis/nerd-fonts#font-installation
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'habamax/vim-sendtoterm'
"Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim' "sostituisce tagbar e funziona con vim-lsp
Plug 'vimwiki/vimwiki'
Plug 'Shougo/vimproc.vim' "cd ~/.vim/bundle/vimproc.vim && make
Plug 'idanarye/vim-vebugger'

call plug#end()

"devicons
"set guifont=Meslo\ Font\ 11
set guifont=DroidSansMono\ Nerd\ Font\ 11
set encoding=utf8

"Close buffer without leaving vim
nnoremap <Leader>q :Bdelete<CR>
nnoremap qq :Bdelete<CR>

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
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
"nmap <leader>f :Files<CR>
"nmap <leader>b :Buffers<CR>
"nmap <leader>c :Commands<CR>
"nmap <leader>h :History<CR>
"nmap <leader>m :Marks<CR>
"nmap <leader>s :Rg
"nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>
"nnoremap <F4> :grep! "\<<cword>\>" . -r<CR>:copen<CR>

" Color Scheme
"colorscheme zenburn
set t_Co=256
set t_ut=
colorscheme codedark

" vim-workspace
"nnoremap <leader>s :ToggleWorkspace<CR>
"let g:workspace_session_directory = $HOME . '/.vim/sessions/'

" vim asterisk, * e # per cercare la parola sotto il cursore senza muoverlo
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)

"camelcasemotion
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap e
sunmap ge

set lazyredraw
set diffopt+=vertical
set showcmd
set ignorecase
set smartcase
set showmatch
set backspace=indent,eol,start
set undofile
set undodir=$HOME/.vim/undo
set mouse=a
set nowrap
set nocompatible
set undolevels=1000
set undoreload=10000
set autowrite
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=79
"highlight OverLength ctermbg=53
"match OverLength /\%81v.*/
set expandtab
set autoindent
set fileformat=unix
set cursorcolumn!
set cursorline!
"if !&diff
"    set cursorline
"endif
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
set ts=4
let s:python_version = 3
filetype plugin on

"remap movements between tabs with ctrl+{h,j,k,l}
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

"esc in terminal goes to normal mode
tnoremap <Esc> <C-W>N
set notimeout ttimeout timeoutlen=100

"remap Redo to U instead of ctrl+r
nnoremap U <C-R>

"nerdtree
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup nerdtreedisablecursorline
    autocmd!
    autocmd FileType nerdtree setlocal nocursorline
augroup end
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1



"disabilita highlight quando entra in InsertMode
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>

"simplyfold
let g:SimpylFold_fold_docstring=0
let g:SimpylFold_fold_import=0
set foldlevelstart=99
nmap <Space> za

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
Arpeggio nmap tn <Esc>:tabn<CR>
Arpeggio nmap tp <Esc>:tabp<CR>
Arpeggio nmap gf <Esc>:Files<CR>
Arpeggio nmap gh <Esc>:History<CR>
Arpeggio nmap gb <Esc>:Buffers<CR>
Arpeggio nmap gc <Esc>:Commands<CR>
Arpeggio nmap gm <Esc>:Marks<CR>
Arpeggio nmap gs <Esc>:Rg
Arpeggio nmap gu <Esc>:UndotreeToggle<CR>
Arpeggio nmap gp <Esc>:call UsePasteReg()<CR>
Arpeggio noremap gj <Esc>:call GoJump()<CR>
Arpeggio inoremap jk <Esc>
Arpeggio map gt <Esc>:NERDTreeToggle<CR>
Arpeggio map gv <Esc>:NERDTreeFind<CR>
Arpeggio inoremap tb <Esc>:Vista!!<CR>
Arpeggio nmap tb <Esc>:Vista!!<CR>
"next buffer
Arpeggio nmap gn <Esc>:bn<CR>
Arpeggio nmap gl :call ToggleLocationList()<CR>

"statusline
let g:airline_powerline_fonts = 1
let g:airline_theme='cobalt2'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#virtualenv#enabled = 1
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l



"vim-maximizer
nnoremap xx :MaximizerToggle<CR>

"indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif



"cscope
 nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>

"rest-console
let g:vrc_set_default_mapping = 0
autocmd FileType rest nnoremap <buffer> <CR> :call VrcQuery()<CR>
let b:vrc_response_default_content_type = 'application/json'

let g:vrc_curl_opts = {
    \ '-i': ''
\}


"vim-asyncomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"vim-lsp
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

let g:lsp_signs_warning = {'text': '!'}
let g:lsp_signs_hint = {'text': '.'}
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_information = {'text': 'i'}

function! LSP_Register(fileType)
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gd :LspDefinition<CR>'
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gD :LspDocumentDiagnostics<CR>'
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gh :LspHover<CR>'
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gf :LspDocumentFormat<CR>'
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gr :LspRename<CR>'
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> ge :LspNextError<CR>'
  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gE :LspPreviousError<CR>'
endfunction


let registerList = [
  \ 'python',
  \ 'html',
  \ 'css',
  \ 'scss',
  \ 'less',
  \ 'sass',
  \ 'typescript',
  \ 'javascript',
  \ 'json'
  \ ]

for item in registerList
  call LSP_Register(item)
endfor


"vista
let g:vista_close_on_jump = 1
let g:vista_default_executive = 'vim_lsp'


"vebugger
let g:vebugger_leader='<Leader>d'
nnoremap <Leader>dr <Esc>:VBGstartPDB %

"vim-diff-enhanced
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
highlight DiffAdd    ctermfg=231 ctermbg=71 gui=none guifg=bg guibg=Red
highlight DiffDelete ctermfg=231 ctermbg=203 gui=none guifg=bg guibg=Red
highlight DiffChange ctermfg=231 ctermbg=216 gui=none guifg=bg guibg=Red
highlight DiffText   ctermfg=231 ctermbg=88 gui=none guifg=bg guibg=Red
autocmd WinEnter * setlocal nocursorline
autocmd WinEnter * setlocal nocursorcolumn
