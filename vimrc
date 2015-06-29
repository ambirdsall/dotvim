set nocompatible
execute pathogen#infect()
call pathogen#helptags()

runtime macros/matchit.vim

""""""""""""""""""""""""""""""""""""""
" MAKE VIM PRETTY AND FORMATTED NICE "
""""""""""""""""""""""""""""""""""""""

" delek, but inheriting a different current linenum color from slate. NICE.
color slate
color delek
" how the shit is syntax highlighting not default. HOW.
syntax enable
" ditto contextual formatting.
filetype indent plugin on
" hybrid linenumbers are the best linenumbers.
set number
set relativenumber
" gutter 1 column bigger than default for readability at a glance.
set numberwidth=5
" redundant with powerline installed; left in b/c Wu-Tang is for the children.
set ruler
" make it obvious when lines run over 80ch; set the color to black for subtlety.
set colorcolumn=81
highlight ColorColumn ctermbg=0
" just because you shouldn't use the mouse doesn't mean you shouldn't be able to
set mouse=a
" default register is the system clipboard, because vim ain't the only program.
set clipboard=unnamed
" 2-space indents; <</>> shifting goes to nearest multiple of 2, even from odds.
set softtabstop=2 shiftwidth=2 shiftround expandtab
" allow hidden buffers, to maintain unsaved changes without cluttering screen.
set hidden
" for fuck's sake, use git for source integrity, not obnoxious backup files.
set noswapfile
set encoding=utf-8
" 450ms is enough to finish typing combos even on a bad day, but not toooo long.
set timeoutlen=450
" split panes spawn to the right and bottom, b/c Principle of Least Surprise.
set splitbelow
set splitright
" always compare diffs with vertical splits.
set diffopt+=vertical
" linenumbers on netrw for easy navigation.
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let NERDTreeShowLineNumbers=1
" fold together all hits from same file in ack results when not under cursor.
let g:ack_autofold_results = 1
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
" Angular Is Not A Crime.
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" powerline is the best line I know.
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

"""""""""""""""""""""""""""
" THE LAND OF AUTOCOMMAND "
"""""""""""""""""""""""""""
if has("autocmd")
  " automatically save files on focus lost. Theoretically.
  au FocusLost * silent! wa

  " Automatically source vimrc when saving changes to it.
  autocmd! BufWritePost vimrc source $MYVIMRC

  " All files in job_search are prose, and can be expected to have long lines.
  autocmd BufNewFile,BufRead ~/job_search/* nnoremap j gj
  autocmd BufNewFile,BufRead ~/job_search/* nnoremap k gk

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  _  _ ___ ___ ___   _____ _  _ ___ ___ ___   ___ ___  "
" | || | __| _ \ __| |_   _| || | __| _ \ __| | _ ) __| "
" | __ | _||   / _|    | | | __ | _||   / _|  | _ \ _|  "
" |_||_|___|_|_\___|   |_| |_||_|___|_|_\___| |___/___| "
"                                                       "
"  __  __   _   ___ ___ ___ _  _  ___ ___               "
" |  \/  | /_\ | _ \ _ \_ _| \| |/ __/ __|              "
" | |\/| |/ _ \|  _/  _/| || .` | (_ \__ \              "
" |_|  |_/_/ \_\_| |_| |___|_|\_|\___|___/              "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" because life is too short to hit shift that often.
nnoremap ; :
nnoremap : ;
" smash escape
inoremap jf <esc>
inoremap fj <esc>
" quickly insert new line above...
inoremap jj <c-o>o
" ...or below the current one in insert mode.
inoremap uu <c-o>O
" quickly jump to inside an empty matched pair (e.g. '()', '""') in insert.
inoremap hh <c-o>?\%<c-r>=line('.')<Return>l\({}\\|\[]\\|<>\\|><\\|()\\|""\\|''\\|><lt>\)?s+1<Return>
" quickly jump to end of current line in insert mode.
inoremap kk <Esc>A
" move around without arrow keys in insert mode.
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
" `Y` yanks from current cursor position to EOL instead of acting like `yy`.
nnoremap Y y$
" I never want to automatically jump to the first match. That's silly.
cnoreabbrev Ack Ack!
" up and down scroll browser-style
noremap <up> <c-y>
noremap <down> <c-e>

""""""""""""""""""""""""""
" TAKE ME TO YOUR LEADER "
""""""""""""""""""""""""""
let mapleader=" "

" mess with this file like it ain't no thing.
nnoremap <leader>ev :tabe ~/.vim/vimrc<cr>
" quickly toggle between last two files.
nnoremap <leader><leader><leader> <c-^>
" jump to first non-whitespace character.
nnoremap <leader>f ^
nnoremap <leader>tts :%s/<tab>/  /g<cr>
" delete all lines whose first non-whitespace character is '#'.
nnoremap <leader>dc :g/\s*#/d<cr>
" reindent entire file.
nnoremap <leader>rei ggVG=<c-o><c-o>
" toggle linewrap.
nnoremap <leader>r :set wrap!<cr>
" save wicked fast.
nnoremap <leader>w :w<cr>
" new lines, but you stay in normal mode.
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" vim-fugitive git status.
nnoremap <leader>s :Gstatus<cr>
" vim-commentary
nmap <leader>c gcc
" ctags
nnoremap <leader>. :TagbarToggle<cr>
" vim-better-whitespace
nnoremap <leader>sw :StripWhitespace<cr>
" vim-nerdtree-tabs
nnoremap <leader>d :NERDTreeTabsToggle<cr>
" vim-easymotion
nnoremap <Leader>l <Plug>(easymotion-lineforward)
nnoremap <Leader>j <Plug>(easymotion-j)
nnoremap <Leader>k <Plug>(easymotion-k)
nnoremap <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

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
