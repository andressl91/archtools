set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'valloric/youcompleteme'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plugin 'DoxygenToolkit.vim'

" Snippets
Plugin 'SirVer/ultisnips'


" Keeping sessions TODO: Look into this, interesting
Plugin 'tpope/vim-obsession'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'gikmx/ctrlp-obsession'


" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" colorscheme
colorscheme old-hope

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" enable all Python syntax highlighting features
let python_highlight_all = 1


" Python specific
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set encoding=utf-8

" C++ specific
au BufNewFile,BufRead *.cpp
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set encoding=utf-8 |
    \ set colorcolumn=110 |
    \ highlight ColorColumn ctermbg=darkgray

" Youcompleteme
let g:ycm_autoclose_preview_window_after_completion=1
" Set  global conf for C++ autocomplete, with:YcmGenerateConfig
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'

" Plugin vim-pydocstring
" Find doq in current path, install to virtualenv if not not there
" pip install doq
" TODO: remove plit in future, should work with system only
let g:pydocstring_doq_path = split(system('which doq'), '\n')[0]
let g:pydocstring_formatter = "google"

" Nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>
" Nerdtree ignore
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Custom key binding
:nnoremap <F5> :rightb vert term<CR>>

" Doxygen
let g:DoxygenToolkit_briefTag_pre="@brief  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns   "
let g:DoxygenToolkit_blockHeader=""
let g:DoxygenToolkit_blockFooter=""
let g:DoxygenToolkit_authorName="Andreas Slyngstad"
let g:DoxygenToolkit_licenseTag="My own license" " <-- !!! Does not end with "\<enter>"

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" NOTE!! <c-s> ONLY WORKS IF "stty -ixon" is set in bashrc, to enable, else
" temrinal freese
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"  let g:UltiSnipsExpandTrigger="<c-s>"
"  let g:UltiSnipsJumpForwardTrigger="<c-b>"
"  let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']






