execute pathogen#infect()
call pathogen#helptags()

color slate

syntax enable

filetype on
filetype indent on
filetype plugin on

set number
set relativenumber
set ruler
set mouse=a
set clipboard=unnamed
set softtabstop=2 shiftwidth=2 expandtab
set noswapfile
set nocompatible
set encoding=utf-8
set timeoutlen=500

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

au FocusLost * silent! wa

if has("autocmd")
    autocmd! BufWritePost .vimrc source $MYVIMRC
endif

let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

noremap :W :w
noremap :Wq :wq
noremap :Q :q
noremap :Q! :q!

inoremap ii <esc>
inoremap jf <esc>
inoremap jj <c-o>o
inoremap uu <c-o>O
inoremap hh <c-o>?\%<c-r>=line('.')<Return>l\({}\\|\[]\\|<>\\|><\\|()\\|""\\|''\\|><lt>\)?s+1<Return>
inoremap kk <Esc>A

nnoremap n nzz
nnoremap N Nzz

noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

noremap <up> <c-y>
noremap <s-up> <c-b>
noremap <down> <c-e>
noremap <s-down> <c-f>

let mapleader=","

noremap <leader>f ^
noremap <leader>tts :%s/<tab>/  /g<cr>
noremap <leader>drc :g/\s*#/d<cr>
noremap <leader>vimrc :tabe ~/.vim/vimrc<cr>
noremap <leader>o o<esc>
noremap <leader>O O<esc>
noremap <leader>ll :Lexplore <bar> vertical resize 30<cr>
noremap <leader>small :vertical resize 30<cr>
noremap <leader>rei ggVG=<c-o><c-o>

" comments
map <leader>c gcc
map <leader>helptags :call pathogen#helptags()<cr>
" ctags
noremap <leader>. :TagbarToggle<cr>
noremap <leader>sw :StripWhitespace<cr>
noremap <leader>l :NERDTree<cr>
" emmet
imap <leader>e <c-y>,

set omnifunc=syntaxcomplete#Complete

" stop that autocomment noise
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" insert evaluated code output into buffer
" http://blog.joncairns.com/2014/10/evaluate-ruby-or-any-command-and-insert-into-vim-buffers/
function! InsertCommand(command)
redir => output
silent execute a:command
redir END
call feedkeys('i'.substitute(output, '^[\n]*\(.\{-}\)[\n]*$', '\1', 'gm'))
endfunction

command -nargs=+ I call InsertCommand(<q-args>)
