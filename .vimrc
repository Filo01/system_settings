filetype off                  " required
set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')

"Plug 'mattn/emmet-vim'
Plug 'pedsm/sprint'
Plug 'junegunn/vim-peekaboo'
Plug 'rickhowe/diffchar.vim'
Plug 'will133/vim-dirdiff'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'idanarye/vim-merginal'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'gregsexton/gitv'
Plug 'yggdroot/indentline'
Plug 'moll/vim-bbye'
Plug 'diepm/vim-rest-console'
Plug 'vim-scripts/indentpython.vim'
"Plug 'sheerun/vim-polyglot' "syntax highlight
Plug 'tmhedberg/SimpylFold'
Plug 'plytophogy/vim-virtualenv'
Plug 'romainl/vim-cool'
Plug 'haya14busa/vim-asterisk'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/camelcasemotion'
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline' " sudo apt-get install fonts-powerline
Plug 'vim-airline/vim-airline-themes' "https://github.com/vim-airline/vim-airline/wiki/Dummies-Guide-to-the-status-bar-symbols-(Powerline-fonts)-on-Fedora,-Ubuntu-and-Windows
Plug 'VundleVim/Vundle.vim'
Plug 'mbbill/undotree'
Plug 'airblade/vim-rooter'
Plug 'kana/vim-arpeggio'
Plug 'kana/vim-textobj-user'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jnurmine/Zenburn'
Plug 'tomasiser/vim-code-dark'
Plug 'ekalinin/Dockerfile.vim'
Plug 'simeji/winresizer'
Plug 'guns/xterm-color-table.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'liuchengxu/vista.vim' "sostituisce tagbar e funziona con vim-lsp
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'Shougo/vimproc.vim' "cd ~/.vim/bundle/vimproc.vim && make
Plug 'idanarye/vim-vebugger'
Plug 'tpope/vim-unimpaired'
Plug 'ryanoasis/vim-devicons' "https://github.com/ryanoasis/nerd-fonts#font-installation
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-python'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-html'
Plug 'neoclide/coc-css'
Plug 'neoclide/coc-yaml'
Plug 'neoclide/coc-highlight'
"Plug 'itchyny/vim-cursorword'

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
"let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'

"fzf funzione per rg+fzf+vim-devicons
if executable('rg')

  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!*/.git/*" --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)  
  
  " Overriding fzf.vim's default :Files command.
  " Pass zero or one args to Files command (which are then passed to Fzf_dev). Support file path completion too.
  command! -nargs=? -complete=file Files call Fzf_dev(<q-args>)

  nnoremap <silent> <leader>e :Files<CR>

endif

" Files + devicons
function! Fzf_dev(qargs)
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'" --expect=ctrl-t,ctrl-v,ctrl-x --multi --bind=ctrl-a:select-all,ctrl-d:deselect-all'

  function! s:files(dir)
    let l:cmd = $FZF_DEFAULT_COMMAND
    if a:dir != ''
      let l:cmd .= ' ' . shellescape(a:dir)
    endif
    let l:files = split(system(l:cmd), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction
  
  function! s:edit_file(lines)
    if len(a:lines) < 2 | return | endif

    let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    
    for l:item in a:lines[1:]
      let l:pos = stridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endfunction

  call fzf#run({
        \ 'source': <sid>files(a:qargs),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '50%' })
endfunction
"nmap <leader>f :Files<CR>
"nmap <leader>b :Buffers<CR>
"nmap <leader>c :Commands<CR>
"nmap <leader>h :History<CR>
"nmap <leader>m :Marks<CR>
"nmap <leader>s :Rg
"nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>
"nnoremap <F4> :grep! "\<<cword>\>" . -r<CR>:copen<CR>

" Color Scheme
colorscheme codedark
"colorscheme zenburn
set t_Co=256
set t_ut=

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

"set lazyredraw
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
"set notimeout ttimeout timeoutlen=100

"remap Redo to U instead of ctrl+r
nnoremap U <C-R>

"format selected json in visual mode
vnoremap = :'<.'>!python -m json.tool<CR>

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
augroup no_highlight
    autocmd TermResponse * nnoremap <esc> :noh<CR><esc>
augroup END

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
"let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l

nnoremap ]t <Esc>:tabn<CR>
nnoremap [t <Esc>:tabp<CR>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

"vim-maximizer
nnoremap xx :MaximizerToggle<CR>

"indentline
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

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
"let g:lsp_signs_enabled = 1         " enable signs
"let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"
"let g:lsp_signs_warning = {'text': '!'}
"let g:lsp_signs_hint = {'text': '.'}
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_information = {'text': 'i'}
"
"function! LSP_Register(fileType)
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gd :LspDefinition<CR>'
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gD :LspDocumentDiagnostics<CR>'
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gh :LspHover<CR>'
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gf :LspDocumentFormat<CR>'
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gr :LspRename<CR>'
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> ge :LspNextError<CR>'
"  exec 'au FileType '. a:fileType .' nnoremap <buffer><silent> gE :LspPreviousError<CR>'
"endfunction
"
"
"let registerList = [
"  \ 'python',
"  \ 'html',
"  \ 'css',
"  \ 'scss',
"  \ 'less',
"  \ 'sass',
"  \ 'typescript',
"  \ 'javascript',
"  \ 'json'
"  \ ]
"
"for item in registerList
"  call LSP_Register(item)
"endfor


"vista
let g:vista_close_on_jump = 1
"let g:vista_default_executive = 'vim_lsp'


"vebugger
let g:vebugger_leader='<Leader>d'
nnoremap <Leader>dr <Esc>:VBGstartPDB %

"vim-diff-enhanced
if &diff
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
highlight DiffAdd    ctermfg=231 ctermbg=65 gui=none guifg=bg guibg=NONE
highlight DiffDelete ctermfg=231 ctermbg=1 gui=none guifg=bg guibg=NONE
highlight DiffChange ctermfg=231 ctermbg=130 gui=none guifg=bg guibg=NONE
highlight DiffText    cterm=bold ctermfg=220 ctermbg=2 gui=none guifg=bg guibg=NONE
autocmd WinEnter * setlocal nocursorline
autocmd WinEnter * setlocal nocursorcolumn


"coc.nvim
nmap <leader>im <Plug>(coc-implementation)
nnoremap <leader>dc <Plug>(coc-declaration)
nmap <leader>df <Plug>(coc-definition)

"markdown-preview
let g:mkdp_auto_close = 1


"easymotion
"let g:EasyMotion_do_mapping = 0 " Disable default mappings

map <Leader> <Plug>(easymotion-prefix)
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


"vim-cool show number of /search matches in the command line
let g:CoolTotalMatches = 1


"vimagit
autocmd FileType magit set nofoldenable


