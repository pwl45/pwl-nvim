" let fortune = system('/home/paul/scripts/line-fortunes.sh')
" echo fortune
let mapleader =" "

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'yegappan/mru'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

" Plug 'vim-syntastic/syntastic'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'osyo-manga/vim-over'
call plug#end()

"Setting variables
set title
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set showmode
set ruler
set laststatus=2
set showcmd
set hlsearch
set inccommand=nosplit
set ignorecase
set smartcase
colorscheme elflord


let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_python_checkers = ['pylint']
let g:EasyMotion_smartcase = 1

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
scriptencoding utf-8
set number relativenumber
" Movement remaps
nnoremap H ^
nnoremap L $
nnoremap Y y$
" Easymotion remaps
" s is bidirectional, t isn't
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)


" Remaps for around/in next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! f(vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap an) :<c-u>normal! f(va(<cr>
onoremap il :<c-u>normal! 0v$<cr>
onoremap al :<c-u>normal! V<cr>
" :onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
" :onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
" Enable autocompletion:
set wildmode=longest,list,full
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
nmap <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non, unlike vim defaults.
set splitbelow splitright

" MRU shortcut: files recent
nmap <leader>fr :MRU<CR>
" Nerd tree
nmap <leader>n :NERDTreeToggle<CR>

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" if has('nvim')
" 	let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
" else
" 	let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
" endif

" quick maps for editing common config files
:nnoremap <leader>ev :vs $MYVIMRC<cr>
:nnoremap <leader>ez :vs $HOME/.zshrc<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>:AirlineRefresh<cr>
" QOL maps to make saving and quitting files easier
:nnoremap <leader>ss :update<cr>
:nnoremap <leader>wq :wq<cr>

augroup autocmds:
	autocmd!
	" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup end

augroup savecmds:
	autocmd!
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
augroup end

" Shortcutting split navigation, saving a keypress:
nmap <Leader>w <C-w>

" Shortcutting file navigation
nmap <Leader>. :e<Space><c-r>=getcwd()<cr>/
nmap <Leader>, :e<Space>
" :cnoremap red edit <c-r>=expand("%:h")<cr>/
" Replace ex mode with gq
nmap Q gq

" Check file in shellcheck:
" nmap <leader>s :!clear && shellcheck -x %<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
" nmap <leader>c :w! \| !compiler "<c-r>%"<CR>

" Save file as sudo on files that require root permission
"cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!



" When shortcut files are updated, renew bash and ranger configs with new material:
"autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
"autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
"autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
	highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all  == 0
		let s:hidden_all = 1
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>

set statusline+=%#warningmsg#
set statusline+=%{FugitiveStatusline()}
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
