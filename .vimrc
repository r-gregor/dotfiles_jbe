" DOMA: LAST CHANGE 20240327
"
" ------------------------- DEFAULT SETTINGS -----------------------------------
set nocompatible                    " This must be first, because it changes other options as a side effect.
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set history=50                      " keep 50 lines of command line history
set ruler                           " show the cursor position all the time
set showcmd                         " display incomplete commands
set incsearch                       " do incremental searching
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smartindent
set laststatus=2
set nohlsearch
set t_Co=256
syntax on
set termguicolors                   " added 20220922 to enable Hex color codes
set number
set relativenumber
set ignorecase
set smartcase
set colorcolumn=110
" from en 20220922
set nowrap
set wildmenu
set wildmode=list:longest,full
set hidden
set path+=**
set background=dark

filetype plugin indent on           "20240913

" added 20231117: fix for disapearing bg color when scrolling!
let &t_ut=''

runtime! ftplugin/man.vim           " added 20221129: load man page into new split -- command 'Man ls' ...

if has('mouse')                     " In many terminal emulators the mouse works just fine, thus enable it.
	set mouse=a
endif

" ----------- TAB CHARACTER SETTINS ---------------------------------
" method 2:
" set listchars=tab:\|\ 

" method 3: (active)
" (insert unicode character fo tight filled triangle big: '<ctrl + v>u25b6\ ')
" u25b6: ▶
" u25b7: ▷
" u25b8: ▸
" u25b9: ▹
" u25bb: ▻
" u27a1: ➡
" u22c5: ⋅
" u237f: ⍿  
"
" u254e: ╎ 
"
" u2506: ┆  
"
" u250a: ┊  
"
" u258f: ▏
" u00bb: »
" set listchars=tab:▶\
" set listchars=tab:⍿⋅
" set listchars=tab:»⋅
" set listchars=tab:▏⋅
set listchars=tab:┊⋅
set list
set listchars+=trail:⋅
nnoremap <space>. :set listchars+=space:⋅ <CR>
nnoremap <space>, :set listchars-=space:⋅ <CR>


" ----------- 20190711 PYTHON HIGHLITING ----------------------------
" let python_highlight_all = 1      " Enable syntax highlighting for python codes
 

" ----------- status bar settup-02 ----------------------------------
" added from: https://github.com/itchyny/lightline.vim
" git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

" ############################################################################################################
"
" ----------------- SYNTAX SETUP MAPPINGS ----------------------
noremap ,stb :so ~/.vimrc <bar> :set syntax=bash<CR>
noremap ,stz :so ~/.vimrc <bar> :set syntax=zig<CR>
noremap ,stp :so ~/.vimrc <bar> :set syntax=python<CR>
noremap ,stc :so ~/.vimrc <bar> :set syntax=c<CR>
noremap ,stj :so ~/.vimrc <bar> :set syntax=java<CR>

" ----------------- ABBREVIATIONS 01 ---------------------------
ab sbng #! /usr/bin/env bash<cr><cr><esc>:so ~/.vimrc <bar> :set syntax=bash
ab pt3 #! /usr/bin/env python3<cr># -*- coding: utf-8 -*-<cr><cr><esc>:so ~/.vimrc <bar> :set syntax=python
ab zst const std = @import("std");<cr><cr>pub fn main() !void {<cr>const out = std.io.getStdOut().writer();<cr>const in = std.io.getStdiIn().reader();<cr><cr>try out.print("I'm Alive!\n", .{});<cr><cr>}<cr><esc>:so ~/.vimrc <bar> :set syntax=zig
ab tb :below terminal
"
" ----------------- ENCLOSING BRACKETS/SQUARE/CURLY ------------
inoremap ${{ ${}<ESC>hli
inoremap {{ {}<ESC>hli
inoremap (( ()<ESC>hli
inoremap [[ []<ESC>hli
inoremap [[[ [[]]<ESC>hli
"
" ------------- C ABBREVIATIONS ------------------------------
" update 20250321
ab cstv #include <stdio.h><CR>#include <string.h><CR><CR><CR>int main(void)<right> {<CR><CR><CR><CR><CR>return 0;<CR>}<ESC>4ki<TAB>printf("I'm Alive");<ESC>:so ~/.vimrc <bar> :set syntax=c
ab cst #include <stdio.h><CR>#include <string.h><CR><CR><CR>int main(int argc, char **argv)<right> {<CR><CR><CR><CR><CR>return 0;<CR>}<ESC>4ki<TAB>printf("I'm Alive");<ESC>:so ~/.vimrc <bar> :set syntax=c
""
" break line at position 110 chars
" 0110lbikba
nnoremap ,b 0110lbi<BS><CR><ESC>
"
" abbreviations for java 20220830
" ------------- JAVA ABBREVIATIONS ------------------------------
iab psvm <TAB>public static void main(String[<Right><Space>args<Right><Space>{<CR><CR><CR><Right><Space>// end main<ESC>kki<CR>
inoremap sout System.out.println("");<ESC>hhi

" ------------- PYTHON ABBREVIATIONS ----------------------------
iab inm if __name__ == '__main__':<CR>
"
" 20250314
" move line under the cursor inside []
noremap ,ss 0vg_xi[<c-r>"]<esc>j<cr>
"
" mapping to insert file search
inoremap <C-f> <C-x><C-f>
"
" 20250314
" move line under the cursor inside []
noremap ,ss 0vg_xi[<c-r>"]<esc>j<cr>

" ############################################################################################################
"
" ----------------- QUOTING: automatic ------------------------------
" 20201224: add/remove quotes arround the word:
" Quote a word consisting of letters from iskeyword.
nnoremap <silent> ,dq :call Quote('"')<CR>
nnoremap <silent> ,sq :call Quote("'")<CR>
nnoremap <silent> ,uq :call UnQuote()<CR>
function! Quote(quote)
	normal mz
	exe 's/\(\k*\%#\k*\)/' . a:quote . '\1' . a:quote . '/'
	normal `zl
endfunction

function! UnQuote()
	normal mz
	exe 's/["' . "'" . ']\(\k*\%#\k*\)[' . "'" . '"]/\1/'
	normal `z
endfunction


" ----------------- 20210127: TOGGLE NUMBER/RELATIVENUMBER ----------
" <ctrl+1> to toggle between just number and number+relativenumber
" from: https://superuser.com/questions/339593/vim-toggle-number-with-relativenumber
"Relative with start point or with line number or absolute number lines
function! NumberToggle()
	if(&number == 1)
		" set number!
		set relativenumber!
		elseif(&relativenumber==1)
		set relativenumber
		set number
		else
		set norelativenumber
		set number
	endif
endfunction

nnoremap ,n :call NumberToggle()<CR>


" ----------------- DRACULA COLOR THEME -----------------------------
" ADDED 20210127
" from: https://draculatheme.com/vim
"
" Install (Vim):
" These are the default instructions using Vim 8's |packages| feature. See sections below, if you use other plugin managers.
"     Create theme folder (in case you don't have yet):
" mkdir -p ~/.vim/pack/themes/start
" If you use vim 8.0 (and not 8.2), you may need to use ~/.vim/pack/themes/opt instead.
"     Navigate to the folder above:
" cd ~/.vim/pack/themes/start
"     Clone the repository using the "dracula" name:
" git clone https://github.com/dracula/vim.git dracula
"     Create configuration file (in case you don't have yet):
" touch ~/.vimrc
"     Edit the ~/.vimrc file with the following content:
" packadd! dracula
" syntax enable
" colorscheme dracula
" ---
" literal:
packadd! dracula
syntax enable
colorscheme dracula

" added 20220922 to correct right background for Dracula CS
hi Normal ctermbg='282a36'


" ----------------- EDGE COLOR THEME --------------------------------
" let g:edge_style = 'neon'
" let g:edge_enable_italic = 1
" let g:edge_disable_italic_comment = 1
" colorscheme edge


" ----------------- SWITCH COLORSCHEMES - PREVIEV -------------------
" added: 20210127
" from https://vim.fandom.com/wiki/Switch_color_schemes
" :source ~/.vim/setcolors.vim
" :SetColors all
" :colors <colorscheme name>
" ... switch to next F8; switch to previous <shift>+F8


" ----------------- COLOR SETTINGS FINAL (IF NO OTHER WORKS) ---------
" colorscheme simple-dark
" colorscheme nord
" colorscheme Mustang
" colorscheme wombat256mod

"
" ----------------- CUSTOM MAPPINGS ---------------------------------
let mapleader = " "

" ADDED 20210226
" search for [12] or [123] troughout a file 
" and ask to deete it --> maped to ,d <comma+d> 
nnoremap ,d :%s/\[\d\+]//gc
 
" ---
" ADDED 20210308
" wildmenu and wildmode are used for command line completion.
" the command line is "expanded" vertically with a list of all the
" options available on your machine displayed in columns and an
" horizontal strip that you can navigate with <Tab> (forward) and
" <S-Tab> (backward).
set wildmenu
set wildmode=list:longest,full

" ---
" added 20210622 (MY PRECIOUS!!)
" comment/uncomment visually selected block
" vnoremap ,pt :s@^@# @<CR>
" updated (d) 20221116
vnoremap ,pt :s@\(^\s*\)\(.*\)@\1# \2@<CR>
vnoremap ,pu :s@\(^\s*\)# @\1@<CR>
vnoremap ,jv :s@\(^\s*\)\(.*\)@\1// \2@<CR>
vnoremap ,ju :s@\(^\s*\)// @\1@<CR>

" html comment/uncomment
vnoremap ,ht :s/\%V\(.*\)\%V/<!-- \1 -->/<CR>
vnoremap ,hu :s/\%V<!-- \(.*\) -->\%V/\1/<CR>
"
" ---
vnoremap ,<space> :s@^.\{1,2\} @@<CR>
vnoremap ,t :s/\(\t\+\) */\1/g<CR>
"
" added 20211101: C-style comment out visual block 
" upodated (d) 20221116
vnoremap ,cc :s/^/ * /<CR>gv"xdO/*<CR><ESC>0C */<ESC>k"xp<CR>
vnoremap ,cu :s/^ \* //<CR>gv"0dddkdd"0P<CR>

" added 20210629 (d) - enclose visual selection
" between <code></code> tags
vnoremap ,cd di<code><CR></code><CR><ESC>kP?<code><CR>:s@.*\(<code>\)@\1@<CR>/</code><CR>:s@.*\(</code>\)@\1@<CR>j

" added 20211105 (en): shift tab and remove spaces
vnoremap ,rr >gv:s/\(\t\+\) \+/\1/g<CR>

" ---
" added 20240327
" clone current line or selection and:
"        - normal mode: paste it under current line
"        - visual selection: paste it over current line, but select lower selection block
"
noremap <leader>c yyp
vnoremap <leader>c yPgv

" ----------------- PLUGGINS ---------------------------------
" Plugins (vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'frazrepo/vim-rainbow'
Plug 'francoiscabrol/ranger.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'dense-analysis/ale'
Plug 'matze/vim-move'
Plug 'terryma/vim-multiple-cursors'

" 20240205
Plug 'fxn/vim-monochrome'

" 20240913
Plug 'rust-lang/rust.vim'

" 20240914
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" ###############################################################
" copied (almost) directly from the vim-lsp docs:
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
"    setlocal signcolumn=yes
"    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"
"    let g:lsp_format_sync_timeout = 1000
"    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled (set the lsp shortcuts) when an lsp server
    " is registered for a buffer.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" ###############################################################


nnoremap <F5> :NERDTreeToggle<CR>

" enable Rainbow globally
" enable Rainbow globally 20210813
let g:rainbow_active = 1

" 20210813: vim's file explorer (Netrw) in left column of size 30 (close with :bd)
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" ranger settings 20210813
let g:ranger_map_keys = 0
nnoremap <leader>r :Ranger<CR>

" mapping to replace spaces and semicolon or just spaces
" at the end of the line:
" effect: single ; at the end of text remains
nnoremap <leader>s :s/ *;*$/;/<esc>j

" ----------------- CROSSHAIR LOCATION ------------------------
" set cursorline
" set cursorcolumn
" hi CursorColumn cterm=NONE ctermbg=red ctermfg=white
" hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=red
" hi CursorLine cterm=NONE cterm=underline ctermbg=NONE
" hi CursorLine guibg=grey16 guifg=NONE
" hi CursorLine guibg=royalblue4 guifg=NONE
" hi CursorColumn guibg=royalblue4 guifg=NONE
" hi CursorLine guibg='#181a1b' guifg=NONE
" hi CursorLine ctermbg=NONE cterm=underline term=NONE guifg=NONE guibg=NONE
" hi CursorColumn cterm=NONE term=NONE guifg=NONE guibg=NONE

" from Plugin vim-code-dark
" colorscheme codedark


" break the sentence at word beginning at 110 chars
" and movi the beginning of the rest to thr next line
nnoremap <leader>b 0110lbi<BS><CR><ESC>

" move entire lines around (from: https://vim.fandom.com/wiki/Moving_lines_up_or_down)
" to enter Alt+j key: Ctrl+v Alt+j in insert mode!
" nnoremap j :m.+1<CR>==
" nnoremap k :m.-2<CR>==
" inoremap j <Esc>:m.+1<CR>==gi
" inoremap j <Esc>:m.-2<CR>==gi
" vnoremap j :m'>+1<CR>gv=gv
" vnoremap k :m'<-2<CR>gv=gv

" move entire lines UP an d DOWN
" to enter instead of Alt key --> SPACE key
nnoremap <Space>j :m.+1<CR>==
nnoremap <Space>k :m.-2<CR>==
vnoremap <Space>j :m'>+1<CR>gv=gv
vnoremap <Space>k :m'<-2<CR>gv=gv

" 20220408: replace start of the line with '$> ' prompt
nnoremap ,4 :s/^/$> /<CR><CR>
vnoremap ,4 :s/^/$> /<CR><CR>
nnoremap <Space>4 :s/^\$ /$> /<CR><CR>
vnoremap <Space>4 :s/^\$ /$> /<CR><CR>

nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>f :FZF<CR>

" abbreviations fo java 20220830
iab psvm <TAB>public static void main(String[<Right><Space>args<Right><Space>{<CR><CR><CR><Right><Space>// end main<ESC>kki<CR>
inoremap sout System.out.println("");<ESC>hhi
iab inm if __name__ == '__main__':<CR>

" added 20220926
" replaces tabs to 4 spaces in visual block
" whole lines -> <shift+v>
" block       -> <ctrl+v>
vnoremap <C-t> :s/\%V\t/    /g<CR>

" added 20221121
" vim-move plugin
let g:move_key_modifier = 'C'
let g:move_key_modifier_visualmode = 'S'

" added 20231004
" removes lagging when editing .h files
set synmaxcol=250
nnoremap <leader>st :syntax off<CR>:syntax on<CR>

" 20240205
" from Plug 'fxn/vim-monochrome'
" let g:monochrome_italic_comments = 1
" colorscheme monochrome

" 20240310
" TO ACCEPT TERMINAL BACKGROUND IMAGE kitty.conf
hi Normal guibg=NONE ctermbg=NONE


" 20250314
" move line under the cursor inside []
noremap ,ss 0vg_xi[<c-r>"]<esc>j<cr>

" 20250515
" copy http link into the [number] holder for the link after lynxd-ed document
" 1 - go inside '[' ']'
" 2 - <c-o> to go to coresponding link at the bottom
" 3 - pres ,lc to do the magic ...
noremap ,lc fhvg_y<C-o>ci[<C-r>0<ESC>

