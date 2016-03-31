set nocompatible
runtime macros/matchit.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""" PLUG THEM PLUGINS IN "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-projectionist'
Plugin 'thoughtbot/vim-rspec'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" GIT INTEGRATION "
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" CUSTOM TEXT OBJECTS "
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-line'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-entire'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" CUSTOM VIM COMMANDS "
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tommcdo/vim-exchange'
Plugin 'vim-scripts/ReplaceWithRegister'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""" SYNTAX HIGHLIGHTING "
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" NAVIGATION "
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-bundler'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" TYPING AIDS "
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/closetag.vim'
Plugin 'ambirdsall/emmet-vim'
Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-endwise'
Plugin 'ntpeters/vim-better-whitespace'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" SEARCHING "
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" COLORS "
Plugin 'altercation/vim-colors-solarized'
Plugin 'dhruvasagar/vim-railscasts-theme'
call vundle#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""" MAKE VIM PRETTY AND FORMATTED NICE "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
filetype indent plugin on
" hybrid linenumbers
set number
set relativenumber
set numberwidth=5 " gutter column bigger for readability
set ruler " redundant with powerline installed; left in b/c Wu-Tang is for the
set laststatus=2 " always display status line, even in single buffer
set colorcolumn=81
set noswapfile " that's git's job
set lazyredraw " don't redraw during macros "
set showcmd
" it is okay to change files without saving every damn thing
set hidden
set encoding=utf-8
highlight ColorColumn ctermbg=0
highlight Folded ctermbg=NONE
" just because you shouldn't use the mouse doesn't mean you shouldn't be able to
set mouse=a
" ditto deleting shit in insert mode
set backspace=indent,eol,start
" default register is the system clipboard, because vim ain't the only program.
set clipboard=unnamed
" 2-space indents; <</>> shifting goes to nearest multiple of 2, even from odds.
set softtabstop=2 shiftwidth=2 shiftround expandtab
" 450ms is enough to finish typing combos even on a bad day, but not toooo long.
set timeoutlen=450
" split panes spawn to the right and bottom, b/c Principle of Least Surprise.
set splitbelow
set splitright
set nowrap " <leader>r toggles wrap for when it's needed
set diffopt+=vertical " always compare diffs with vertical splits.
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_banner=0

 " Speed up viewport scrolling {{{
  nnoremap <C-e> 3<C-e>
  nnoremap <C-y> 3<C-y>
  " }}}

" fold together all hits from same file in ack results when not under cursor.
let g:ack_autofold_results = 1
" Treat <li> and <p> tags like the block tags they are.
let g:html_indent_tags = 'li\|p'
" no thanks. It's the default, but explicitness is a virtue.
let g:syntastic_check_on_open=0
let g:syntastic_mode_map = { "mode": "active",
      \ "active_filetypes": ["ruby"],
      \ "passive_filetypes": ["javascript"] }
" Angular Is Not A Crime.
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" powerline is the best line I know.
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""" THE LAND OF AUTOCOMMAND "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " automatically rebalance splits on resize
  autocmd VimResized * :wincmd =

  " cron jobs, tho
  autocmd filetype crontab setlocal nobackup nowritebackup

  " nice line formatting for free in markdown
  autocmd bufreadpre *.md setlocal textwidth=80
  autocmd bufreadpre *.markdown setlocal textwidth=80

  " automatically save files on focus lost. Theoretically.
  au FocusLost * silent! wa

  " Automatically source vimrc when saving changes to it.
  autocmd! BufWritePost vimrc source $MYVIMRC

  " All files in job_search are en_us prose, and will have long lines.
  autocmd BufNewFile,BufRead ~/job_search/* nnoremap j gj
  autocmd BufNewFile,BufRead ~/job_search/* nnoremap k gk
  autocmd BufNewFile,BufRead ~/job_search/* setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead ~/job_search/* nnoremap <leader>sp :setlocal spell! spelllang=en_us<cr>
  autocmd BufNewFile,BufRead ~/job_search/* setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""  _  _ ___ ___ ___   _____ _  _ ___ ___ ___   ___ ___  "
"""""""""""""""""""""""" | || | __| _ \ __| |_   _| || | __| _ \ __| | _ ) __| "
"""""""""""""""""""""""" | __ | _||   / _|    | | | __ | _||   / _|  | _ \ _|  "
"""""""""""""""""""""""" |_||_|___|_|_\___|   |_| |_||_|___|_|_\___| |___/___| "
""""""""""""""""""""""""                                                       "
""""""""""""""""""""""""  __  __   _   ___ ___ ___ _  _  ___ ___               "
"""""""""""""""""""""""" |  \/  | /_\ | _ \ _ \_ _| \| |/ __/ __|              "
"""""""""""""""""""""""" | |\/| |/ _ \|  _/  _/| || .` | (_ \__ \              "
"""""""""""""""""""""""" |_|  |_/_/ \_\_| |_| |___|_|\_|\___|___/              "
""""""""""""""""""""""""                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" scroll browser-style
noremap <up> <c-y>
noremap <down> <c-e>
nnoremap <left> zh
nnoremap <right> zl
" because life is too short to hit shift that often.
nnoremap ; :
nnoremap : ;
" wizard party!!!!! very magic by default
:nnoremap / /\v
:cnoremap %s/ %s/\v
" `Y` yanks from current cursor position to EOL instead of acting like `yy`.
nnoremap Y y$
" smash escape            CURSOR POSITION AFTER:
"                       |F| | |J| | <= backwards like esc <=
inoremap jf <esc>
inoremap fj <esc>
vnoremap jf <esc>
vnoremap fj <esc>
"                       | | | |J|K| => doesn't move =>
inoremap jk <esc>l
inoremap kj <esc>l
" quickly insert new line above...
inoremap jj <c-o>o
" ...or below the current one in insert mode.
inoremap uu <c-o>O
" quickly jump to end of current line in insert mode.
inoremap kk <Esc>A
"   or beginning
inoremap hh <Esc>I
" move around without arrow keys in insert mode.
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
" typing `//` in visual mode searches for the selection
vnoremap // y/<C-R>"<CR>

" jump to previous quickfix item
nmap [q :cprev
" jump to next quickfix item
nmap ]q :cnext
" jump to first quickfix item
nmap [Q :cfirst
" jump to last quickfix item
nmap ]Q :clast
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""" TAKE ME TO YOUR LEADER "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" RAW DANG VIM:
let mapleader=" "

" mess with this file like it ain't no thing.
nnoremap <leader>ev :tabe ~/.vim/vimrc<cr>
" quickly toggle between last two files.
nnoremap <leader><leader><leader> <c-^>
" see open buffers or jump to a specific number
nnoremap <leader>b :buffer
" jump to first non-whitespace character.
nnoremap <leader>f ^
" quickly jump to inside an empty matched pair (e.g. '()', '""')
nnoremap <leader>in ?\%<c-r>=line('.')<Return>l\({}\\|\[]\\|<>\\|><\\|()\\|""\\|''\\|><lt>\)?s+1<Return>
" for when using textwidth: formats current paragraph
nnoremap <leader>ind gqip
" reindent entire file.
nnoremap <leader>rei ggVG=<c-o><c-o>
" yank every dang thing.
nnoremap <leader>ya ggVGy<c-o><c-o>
" toggle linewrap.
nnoremap <leader>r :set wrap!<cr>
" save wicked fast.
nnoremap <leader>w :w<cr>
" new lines, but you stay in normal mode.
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
" open file in vertical split
nnoremap <leader>gf <c-w>f<bar><c-w>L
" CSS tags
" place your cursor on an id or class and hit <leader>]
" to jump to the definition
nnoremap <leader>] :tag /<c-r>=expand('<cword>')<cr><cr>
nnoremap <leader>tts :%s/\t/  /g<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" PLUGINS AND WHATNOT:

" vim-fugitive
nnoremap <leader>s :Gstatus<cr>
nnoremap <leader>bl :Gblame<cr>
nnoremap <leader>ci :Gcommit
nnoremap <leader>di :Gdiff

" vim-rspec
nnoremap <leader>t :call RunCurrentSpecFile()<cr>
nnoremap <leader>n :call RunNearestSpec()<cr>
nnoremap <leader>l :call RunLastSpec()<cr>
" nnoremap <leader>a :call RunAllSpecs()<cr>

" ag.vim
" The terminal whitespace is on purpose here
nnoremap <leader>ag :Ag! 
nnoremap <leader>ack :Ack! 
" I never want to automatically jump to the first match. That's silly.
cnoreabbrev Ack Ack!

" vim-commentary
nmap <leader>c gcc
" ctags
nnoremap <leader>. :TagbarToggle<cr>
" vim-better-whitespace
nnoremap <leader>sw :StripWhitespace<cr>
" vim-nerdtree-tabs
" nnoremap <leader>d :NERDTreeTabsToggle<cr>
" easymotion
nmap <leader>a <Plug>(easymotion-s2)

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

command! -nargs=+ I call InsertCommand(<q-args>)
