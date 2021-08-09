" let fortune = system('/home/paul/scripts/line-fortunes.sh')
echo "veni, vidi, vim"
let mapleader =" "
"Folded by default: Plugin installation, variable settings {{{
	" plugshit ---------------------- {{{
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
		Plug 'jreybert/vimagit'
		Plug 'flazz/vim-colorschemes'
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'junegunn/fzf.vim'
		Plug 'airblade/vim-rooter'
		" Plug 'vim-syntastic/syntastic'
		" Plug 'neoclide/coc.nvim', {'branch': 'release'}
		" Plug 'osyo-manga/vim-over'
		call plug#end()
	" }}}

	"Setting default variables ------------------- {{{
		set title
		set bg=light
		set go=a
		set mouse=a
		set nohlsearch
		set clipboard+=unnamedplus
		" set hidden
		set showmode
		set ruler
		set laststatus=2
		set showcmd
		set hlsearch
		set inccommand=nosplit
		set ignorecase
		set smartcase
		set number relativenumber
		set encoding=utf-8
		" Splits open at the bottom and right, which is intuitive, unlike vim defaults.
		set splitbelow splitright
		" Enable commandline autocompletion:
		set wildmode=longest,list,full
		colorscheme elflord
		set nocompatible
		filetype plugin on
		syntax on

	" end setting default variables}}}
	"Setting plugin variables ------------------- {{{
		" Necessary for cool symbols in airline statusbar
		let g:airline_powerline_fonts = 1
		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_auto_loc_list = 1
		let g:syntastic_check_on_open = 1
		let g:syntastic_check_on_wq = 0
		let g:EasyMotion_smartcase = 1
	" end setting plugin variables}}}
"}}}

" Search and movement remaps
	" Use H (capital h) to go to beginning of line
	nnoremap H ^
	" capital l for end of line
	nnoremap L $
	" make capital Y behave like capital C, capital D, etc. 
	nnoremap Y y$
	" nnoremap e b
	" nnoremap E B
	nnoremap c "_c

	vnoremap < <gv
	vnoremap > <gv

	" (S)ubstitute
	nnoremap S :%s//g<Left><Left>
	" (s)earch (w)hole word
	nnoremap <leader>sw /\<\><Left><Left>

	" vim-easymotion: 
	" easymotion-s2: bidirectional search for two characters over multiple lines. 
		nmap s <Plug>(easymotion-s2)
	" easymotion-sl: bidrectional search for signle char over current line. 
		nmap f <Plug>(easymotion-sl)
	" easymotion-sl: bidrectional search for signle char over current line. 
		nmap t <Plug>(easymotion-tl)

" Remaps for around/in next/last parentheses. Not very useful, but cool. 
	onoremap in( :<c-u>normal! f(vi(<cr>
	onoremap in) :<c-u>normal! f(vi(<cr>
	onoremap an( :<c-u>normal! f(va(<cr>
	onoremap an) :<c-u>normal! f(va(<cr>

" QOL maps to make saving and quitting files easier
	" (s)ave
	:nnoremap <leader>ss :update<cr>
	" (s)ave and (q)uit
	:nnoremap <leader>sq :wq<cr>
	" (w)rite and (q)uit
	:nnoremap <leader>wq :wq<cr>
	" (q)uit
	:nnoremap <leader>qq :q<cr>
	" No remap for :q! by default. Accidentally fat-fingering q! on a file you've changed is not something you want to do. 

" Uncategorized leader maps
	" Spell-check: (o)rthography
	nmap <leader>o :setlocal spell! spelllang=en_us<CR>
	" (m)a(g)it shortcut:
	nmap <leader>mg :Magit<CR>
	" MRU shortcut: (f)iles (r)ecent
	nmap <leader>mr :MRU<CR>
	nmap <leader>ff :Files<CR>
	nmap <leader>fr :Rg<CR>
	" (n)erd tree
	nmap <leader>n :NERDTreeToggle<CR>

" quick maps for editing common config files
	" (e)dit (v)imrc
	:nnoremap <leader>ev :e $MYVIMRC<cr>
	" (v)split (v)imrc
	:nnoremap <leader>vv :vs $MYVIMRC<cr>
	" (e)dit (v)imrc
	:nnoremap <leader>ez :vs $HOME/.zshrc<cr>
	" (s)ource (v)imrc
	:nnoremap <leader>sv :source $MYVIMRC<cr>:AirlineRefresh<cr>

" Auto commands
	augroup general:
		autocmd!
		" Disables automatic commenting on newline:
		autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	augroup end

	augroup savecmds:
		autocmd!
		" autocmd BufWritePost *sxhkdrc !killall sxhkd; setsid sxhkd &
		" TODO: Break this out into a function, save original cursor position with a mark and go back. 
		" autocmd BufWritePre * %s/\s\+$//e
		" autocmd BufWritePre * %s/\n\+\%$//e
		" autocmd BufWritePre *.[ch] %s/\%$/\r/e
	augroup end

	augroup filetype_vim
	    autocmd!
	    " Fold some less interesting stuff
	    autocmd FileType vim setlocal foldmethod=marker
	augroup end

" Shortcutting split navigation, saving a keypress:
	nmap <Leader>w <C-w>

" Shortcutting file navigation. TODO: Make this better, use projectile or something similar. 
	" (l)ist and switch buffers
	nmap <Leader>l :ls<CR>:b<space>
	nmap <Leader>. :e<Space><c-r>=getcwd()<cr>/
	nmap <Leader>, :e<Space>

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
	highlight! link DiffText MatchParen
endif

" Toggling bottom statusbar: mapped to <leader>h {{{
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
	" TODO: <leader>h is far too valuable of binding to waste on this function. C
	" Change when you find something better for it. 
	nnoremap <leader>h :call ToggleHiddenAll()<CR>
"}}}

" Statusline stuff
	set statusline+=%#warningmsg#
	set statusline+=%{FugitiveStatusline()}
	" set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

nnoremap <leader>cs :colorscheme<space>
" Cool colorschemes: 
	" 256_noir: dark and scary
	
