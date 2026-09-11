" DOMA: LAST CHANGE 20260420 (cursor columns like in en)

" ========================= DEFAULT SETTINGS ================================================================
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
set hlsearch                        " set nohlsearch
set t_Co=256
set termguicolors                   " added 20220922 to enable Hex color codes
set number
set relativenumber
set ignorecase
set smartcase
set colorcolumn=110
set nowrap                          " from en 20220922
set hidden
set path+=**
set background=dark
set viminfo='100,f1                 "20260210: remember local and global marks for 100 files

" ADDED 20210308
" wildmenu and wildmode are used for command line completion.
" the command line is "expanded" vertically with a list of all the
" options available on your machine displayed in columns and an
" horizontal strip that you can navigate with <Tab> (forward) and
" <S-Tab> (backward).
set wildmenu
set wildmode=list:longest,full

" for 'gq+ command 20251005:
set textwidth=110
set formatoptions-=t
set formatoptions+=l


" ============= OTHER SETTINGS ==============================================================================

syntax on
hi ColorColumn ctermbg=232 guibg='#3F4354'
filetype plugin indent on           "20240913
let &t_ut=''                        " added 20231117: fix for disapearing bg color when scrolling!
runtime! ftplugin/man.vim           " added 20221129: load man page into new split -- command 'Man ls' ...


" --- MOUSE DISPLAY SETTING ---
if has('mouse')                     " In many terminal emulators the mouse works just fine, thus enable it.
	set mouse=a
endif


" --- TAB CHARACTER SETTINGS ---
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

" --- HIDE/DISPLAY TAB CHARACTE ---
nnoremap <SPACE>0 :set listchars=tab:\ \ ,nbsp:·<CR>
nnoremap <SPACE>t :set listchars=tab:┊⋅<CR>
" 20260911


" === PYTHON SETTINGS ===
autocmd Filetype python setlocal noexpandtab

" --- 20190711 PYTHON HIGHLITING ---
" let python_highlight_all = 1      " Enable syntax highlighting for python codes
 

" --- STATUS BAR SETUP ---
" added from: https://github.com/itchyny/lightline.vim
" git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
" let g:lightline = {
"       \ 'colorscheme': 'dracula',
"       \ }

" --- 20260522 catpucin_ theme for lightline ---
let g:lightline = {'colorscheme': 'catppuccin_mocha'}
"

" --- TOGGLE NUMBER/RELATIVENUMBER ---
"  20210127
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

" --- TOGGLE NUMBER/RELATIVENUMBER ---
nnoremap ,n :call NumberToggle()<CR>

" --- CROSSHAIR LOCATION ---
" 20260420
set cursorline
set cursorcolumn
hi CursorColumn cterm=NONE ctermbg=232 guifg=NONE guibg='#3F4354'
hi CursorLine cterm=NONE ctermbg=232 guifg=NONE guibg='#3F4354'
" staro:
" hi CursorColumn cterm=NONE ctermbg=red ctermfg=white
" hi CursorColumn cterm=NONE ctermbg=NONE ctermfg=red
" hi CursorLine cterm=NONE cterm=underline ctermbg=NONE
" hi CursorLine guibg=grey16 guifg=NONE
" hi CursorLine guibg=royalblue4 guifg=NONE
" hi CursorColumn guibg=royalblue4 guifg=NONE
" hi CursorLine guibg='#181a1b' guifg=NONE
" hi CursorLine ctermbg=NONE cterm=underline term=NONE guifg=NONE guibg=NONE
" hi CursorColumn cterm=NONE term=NONE guifg=NONE guibg=NONE


" =========== PLUGGINS (vim=plug) ===========================================================================
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
" Plug 'frazrepo/vim-rainbow'
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

" 20260522
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

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

" vim-move plugin
" added 20221121
let g:move_key_modifier = 'C'
let g:move_key_modifier_visualmode = 'S'

" 20240205
" from Plug 'fxn/vim-monochrome'
" let g:monochrome_italic_comments = 1
" colorscheme monochrome







" ================= ABBREVIATIONS ===========================================================================
" ab sbng #! /usr/bin/env bash<cr><cr><esc>:so ~/.vimrc <bar> :set syntax=bash
" updated 20250807: insert datestamp
ab sbng #! /usr/bin/env bash<cr># fname: <c-r><cr># <c-r>=strftime('%Y%m%d')<cr> v1<cr># ---<cr><esc>:so ~/.vimrc <bar> :set syntax=bash


ab pt3 #! /usr/bin/env python3<cr># -*- coding: utf-8 -*-<cr><cr><esc>:so ~/.vimrc <bar> :set syntax=python
ab zst const std = @import("std");<cr><cr>pub fn main() !void {<cr>const out = std.io.getStdOut().writer();<cr>const in = std.io.getStdiIn().reader();<cr><cr>try out.print("I'm Alive!\n", .{});<cr><cr>}<cr><esc>:so ~/.vimrc <bar> :set syntax=zig
ab tb :below terminal

" ------------- C ABBREVIATIONS ------------------------------
" update 20250321
ab cstv #include <stdio.h><CR>#include <string.h><CR><CR><CR>int main(void)<right> {<CR><CR><CR><CR><CR>return 0;<CR>}<ESC>4ki<TAB>printf("I'm Alive");<ESC>:so ~/.vimrc <bar> :set syntax=c
ab cst #include <stdio.h><CR>#include <string.h><CR><CR><CR>int main(int argc, char **argv)<right> {<CR><CR><CR><CR><CR>return 0;<CR>}<ESC>4ki<TAB>printf("I'm Alive");<ESC>:so ~/.vimrc <bar> :set syntax=c


" --- JAVA ABBREVIATIONS ---
" abbreviations for java 20220830
iab psvm <TAB>public static void main(String[<Right><Space>args<Right><Space>{<CR><CR><CR><Right><Space>// end main<ESC>kki<CR>
inoremap sout System.out.println("");<ESC>hhi
iab inm if __name__ == '__main__':<CR>


" --- PYTHON ABBREVIATIONS ---
iab inm if __name__ == '__main__':<CR>


" ================= MAPPINGS ================================================================================

" --- SYNTAX SETUP MAPPINGS ---
noremap ,stb :so ~/.vimrc <bar> :set syntax=bash<CR>
noremap ,stz :so ~/.vimrc <bar> :set syntax=zig<CR>
noremap ,stp :so ~/.vimrc <bar> :set syntax=python<CR>
noremap ,stc :so ~/.vimrc <bar> :set syntax=c<CR>
noremap ,stj :so ~/.vimrc <bar> :set syntax=java<CR>
noremap ,stv :so ~/.vimrc <BAR> :set syntax=vim<CR>

" --- ENCLOSING BRACKETS/SQUARE/CURLY ---
inoremap ${{ ${}<ESC>hli
inoremap {{ {}<ESC>hli
inoremap (( ()<ESC>hli
inoremap [[ []<ESC>hli
inoremap [[[ [[]]<ESC>hli


" --- BREAK LINE AT POSITION 110 CHARS ---
nnoremap ,b 0110lbi<BS><CR><ESC>
" 0110lbikba


" --- MOVE LINE UNDER THE CURSOR INSIDE [] ---
noremap ,ss 0vg_xi[<c-r>"]<esc>j<cr>

" --- MAPPING TO INSERT FILE SEARCH ---
inoremap <C-f> <C-x><C-f>

" --- MOVE LINE UNDER THE CURSOR INSIDE [] ---
noremap ,ss 0vg_xi[<c-r>"]<esc>j<cr>

" --- ADD/REMOVE QUOTES ARROUND THE WORD ---
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


" --- CUSTOM MAPPINGS ---
let mapleader = " "


" --- SEARCH AND REPLACE [12] AND [123] WITH CONFIRMATION ---
nnoremap ,d :%s/\[\d\+]//gc


" --- COMMENT/UNCOMMENT VISUALLY SELECTED BLOCK ---
vnoremap ,pt :s@\(^\s*\)\(.*\)@\1# \2@<CR>
vnoremap ,pu :s@\(^\s*\)# @\1@<CR>
vnoremap ,jv :s@\(^\s*\)\(.*\)@\1// \2@<CR>
vnoremap ,ju :s@\(^\s*\)// @\1@<CR>


" --- HTML COMMENT/UNCOMMENT ---
vnoremap ,ht :s/\%V\(.*\)\%V/<!-- \1 -->/<CR>
vnoremap ,hu :s/\%V<!-- \(.*\) -->\%V/\1/<CR>
"
"
" --- REMOVE LEADING CHARS WITH SPACE IN VISUAL MODE ---
vnoremap ,<space> :s@^.\{1,2\} @@<CR>


" --- REPLACE MULTIPLE <tab>S WITH TRAILING <space> WITH <tab>S ONLY ---
vnoremap ,t :s/\(\t\+\) */\1/g<CR>


" --- c-STYLE COMMENT OUT VISUAL BLOCK  ---
vnoremap ,cc :s/^/ * /<CR>gv"xdO/*<CR><ESC>0C */<ESC>k"xp<CR>
vnoremap ,cu :s/^ \* //<CR>gv"0dddkdd"0P<CR>


" --- ENCLOSE VISUAL SELECTION BETWEEN <code></code> TAGS
vnoremap ,cd di<code><CR></code><CR><ESC>kP?<code><CR>:s@.*\(<code>\)@\1@<CR>/</code><CR>:s@.*\(</code>\)@\1@<CR>j


" --- SHIFT TAB AND REMOVE SPACES ---
vnoremap ,rr >gv:s/\(\t\+\) \+/\1/g<CR>

" --- CLONE CURRENT LINE OR SELLECTION ---
noremap <leader>c yyp
vnoremap <leader>c yPgv

nnoremap <F5> :NERDTreeToggle<CR>

" enable Rainbow globally
" enable Rainbow globally 20210813
" let g:rainbow_active = 1


" --- VIM'S FILE EXPLORER (Netrw) ---
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>


" --- RANGER SETTINGS ---
let g:ranger_map_keys = 0
nnoremap <leader>r :Ranger<CR>


" --- REPLACE SPACES BEFOR ; AT THE END OF THE LINE ---
nnoremap <leader>s :s/ *;*$/;/<esc>j


" --- BREAK THE SENTENCE AT WORD BEGINNING AT 110 CHARS ---
nnoremap <leader>b 0110lbi<BS><CR><ESC>


" --- MOVE ENTIRE LINES AROUND ---
" move entire lines around (from: https://vim.fandom.com/wiki/Moving_lines_up_or_down)
" to enter Alt+j key: Ctrl+v Alt+j in insert mode!
" nnoremap j :m.+1<CR>==
" nnoremap k :m.-2<CR>==
" inoremap j <Esc>:m.+1<CR>==gi
" inoremap j <Esc>:m.-2<CR>==gi
" vnoremap j :m'>+1<CR>gv=gv
" vnoremap k :m'<-2<CR>gv=gv


" --- MOVE ENTIRE LINES up AND down ---
nnoremap <Space>j :m.+1<CR>==
nnoremap <Space>k :m.-2<CR>==
vnoremap <Space>j :m'>+1<CR>gv=gv
vnoremap <Space>k :m'<-2<CR>gv=gv


" --- REPLACE START OF THE LINE WITH '$> ' PROMPT ---
nnoremap ,4 :s/^/$> /<CR><CR>
vnoremap ,4 :s/^/$> /<CR><CR>
nnoremap <Space>4 :s/^\$ /$> /<CR><CR>
vnoremap <Space>4 :s/^\$ /$> /<CR><CR>


" --- FILE MANAGERS ---
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fe :FZF -e<CR>


" --- REPLACES TABS TO 4 SPACES IN VISUAL BLOCK ---
vnoremap <C-t> :s/\%V\t/    /g<CR>


" --- REMOVES LAGGING WHEN EDITING *.h FILES ---
set synmaxcol=250
nnoremap <leader>st :syntax off<CR>:syntax on<CR>


" --- ACCEPT TERMINAL BACKGROUND IMAGE kitty.conf ---
hi Normal guibg=NONE ctermbg=NONE


" --- MOVE LINE UNDER THE CURSOR INSIDE [] ---
noremap ,ss 0vg_xi[<c-r>"]<esc>j<cr>

"
" --- COPY HTTP LINK INTO THE [NUMBER] HOLDER FOR THE LINK AFTER LYXD_ED DOCUMENT ---
noremap ,lc fhvg_y<C-o>ci[<C-r>0<ESC>
" 1 - go inside '[' ']'
" 2 - <c-o> to go to coresponding link at the bottom
" 3 - pres ,lc to do the magic ...


" --- OPEN ALL BUFFERS INTO SEPARATE TABS ---
map ,bt :bufdo tab split<CR><CR>


" --- TABLE ROW DIVIDERS ---
noremap ,tr 0yyjp}P<ESC>j


" --- MOVE '{' AFTER 'FUNC() ' ---
noremap <space>f jddkA {<ESC>

" --- SET SYNTAX MAPPINGS ---
noremap <space>ss :set syntax=<CR>
noremap <space>ssh :set syntax=sh<CR>
noremap <space>ssc :set syntax=c<CR>
noremap <space>sst :set syntax=text<CR>
noremap <space>ssj :set syntax=java<CR>
noremap <space>ssp :set syntax=python<CR>
noremap <space>ssg :set syntax=go<CR>
noremap <SPACE>ssv :set syntax=vim<CR>


" --- INDENT/FORMAT main{} BLOCK ---
nnoremap <space>0 0Vf{%=gv:s/\(\t\+\) \+/\1/g<CR>
" 20251223
" select whole 'main() { ... }' block, formate it with '=' and
" replace 4 spaces with tabs


" --- INITIAL CONFIG SOURCE AND SYNTAX SETUP ---
nnoremap <space>v :so ~/.vimrc <BAR> set syntax=c <BAR> :noh<CR>


" --- MOVE LINE UNDER THE CURSOR INSIDE [] ---
nnoremap ,sb 0vg_xi[<c-r>"]<esc>j<cr>
vnoremap ,sb xi[]<ESC>h""p<ESC>


" --- CHANGE BUFFER TO FILE FROM LIST ---
nnoremap <Leader>b :buffers<CR>:buffer<Space>
" from:
" vim-working-with-buffers-multif-5ppp-20260210.txt
" https://builtin.com/articles/working-with-buffers-in-vim


" --- SEARCH IN VIM'S FILE EDIT HISTORY AND OPEN IT FOR EDIT/VIEW ---
nnoremap <leader>oo :oldfiles<CR>e #<
" must enter colon ':' and add a line number

" --- REPLACE LEADING 4 SPACES TO TABS ---
nnoremap <space>4t :%s/\(^\s*\)\@<=    /\t/g<CR><BAR>:noh<CR>
vnoremap <space>4t :s/\(^\s*\)\@<=    /\t/g<CR><BAR>:noh<CR>

" --- REPLACE LEADING 2 SPACES TO TABS ---
nnoremap <space>2t :%s/\(^\s*\)\@<=  /\t/g<CR><BAR>:noh<CR>
vnoremap <space>2t :s/\(^\s*\)\@<=  /\t/g<CR><BAR>:noh<CR>


" --- REPLACE SINGLE QUOTE INSIDE WORDS WITH APOSTROPHE COMMAND ---
nnoremap <space>9 :%s/\([[:alpha:]]\)'\([[:alpha:]]\)/\1´\2/g<CR><BAR>:noh<CR>


" --- RETAB VISUAL SELLECTION ---
vnoremap ,rt :retab!<CR>


" --- MOVE SELECTED TEXT BETWEEN '', OR BETWEEN "" ---
vnoremap <space>sq xi''<ESC>h""p<ESC>
vnoremap <space>dq xi""<ESC>h""p<ESC>

" --- REMOVE ALL '[DIGITS]' IN CURRENT LINE OR IN VISUAL SELLECTIOM ---
nnoremap ,ds :s/\[.\+\]//g<CR>:noh<CR>
vnoremap ,ds :s/\[.\+\]//g<CR>:noh<CR>

" --- REMOVE '[...]' (DIGITS) IN CURRENT LINE OR SELECTION ---
nnoremap ,ds :s/\[.\+\]//g<CR>:noh<CR>
vnoremap ,ds :s/\[.\+\]//g<CR>:noh<CR>

" --- INSERT DATESTAMP 'yyyyMMDD' ---
nnoremap ,dt "=strftime('%Y%m%d')<cr>P<cr>
inoremap ,dt <c-r>=strftime('%Y%m%d')<cr>
vnoremap ,dt <c-r>=strftime('%Y%m%d')<cr>

" --- WRITE AND CLOSE BUFFE ---
noremap ,wd :w <bar> :bd<cr>
" or:
" noremap ,wd :w \| :bd<cr>

" --- CHANGE FROM 'NONMODIFIABLE' TO 'MODIFIABLE' ---
noremap ,mf :set modifiable<CR>

" --- CHANGE FROM 'MODIFIABLE' TO 'NONMODIFIABLE' ---
noremap ,nf :set nomodifiable<CR>

" --- PUT SELLECTION INSIDE DOUBLE OR SINGLE QUOTE ---
vnoremap 1q c''<esc>hp
vnoremap 2q c""<esc>hp

" ================== COLORSCHEMES ==============================
"
" --- DRACULA COLOR THEME ---
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
" packadd! dracula
" syntax enable
" colorscheme dracula

" 20260522
colorscheme catppuccin_mocha

" added 20220922 to correct right background for Dracula CS
" hi Normal ctermbg='282a36'
hi Normal ctermbg='000000'


" --- EDGE COLOR THEME ---
" let g:edge_style = 'neon'
" let g:edge_enable_italic = 1
" let g:edge_disable_italic_comment = 1
" colorscheme edge


" --- SWITCH COLORSCHEMES ---
" added: 20210127
" from https://vim.fandom.com/wiki/Switch_color_schemes
" :source ~/.vim/setcolors.vim
" :SetColors all
" :colors <colorscheme name>
" ... switch to next F8; switch to previous <shift>+F8


" from Plugin vim-code-dark
" colorscheme codedark


" ----------------- COLOR SETTINGS FINAL (IF NO OTHER WORKS) ---------
" colorscheme simple-dark
" colorscheme nord
" colorscheme Mustang
" colorscheme wombat256mod

