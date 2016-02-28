let &runtimepath .= ',~/.vim/plugin'

set encoding=utf-8
set tenc=utf-8

" Число символов для отступа
set noexpandtab tabstop=8 shiftwidth=8
"set tabstop=4
"set shiftwidth=4
"set expandtab
set smarttab
set ruler       " Отображение текущей позиции
set smartindent " Умные отступы

" Перенос строк
set wrap

" Автоотступы
set ai

" Автоотступы в стиле С
set cin

" Поиск и подсветка результатов поиска и совпадение скобок
set showmatch
set hlsearch
set incsearch
set smartcase
set ignorecase
set colorcolumn=100
highlight ColorColumn ctermbg=gray ctermfg=white guibg=#592929


" Номера строк
set number
" set relativenumber

" Сохранение резервных копий
set backup

" Перенос по словам, а не по буквам
set linebreak
set dy=lastline

" Отображение последней команды
set showcmd
set mouse=nicr
set textwidth=130
set backspace=indent,eol,start
set laststatus=2 " Отображение имени файла в статусной строке

"execute pathogen#infect()
syntax on
"filetype plugin indent on

filetype indent plugin on
au BufNewFile,BufRead *.ejs set filetype=html

"autocmd FileType *
"    \ if &omnifunc != '' |
"    \   call SuperTabChain(&omnifunc, "<c-p>") |
"    \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    "\ let g:SuperTabDefaultCompletionType = "context" |
"    \ endif

set foldminlines=4

highlight Folded guibg=blue guifg=red
highlight FoldColumn guibg=darkgrey guifg=white

function GetPerlFold()
  if getline(v:lnum) =~ '^\s*sub\s'
    return ">1"
  elseif getline(v:lnum) =~ '\}\s*$'
    let my_perlnum = v:lnum
    let my_perlmax = line("$")
    while (1)
      let my_perlnum = my_perlnum + 1
      if my_perlnum > my_perlmax
        return "<1"
      endif
      let my_perldata = getline(my_perlnum)
      if my_perldata =~ '^\s*\(\#.*\)\?$'
        " do nothing
      elseif my_perldata =~ '^\s*sub\s'
        return "<1"
      else
        return "="
      endif
    endwhile
  else
    return "="
  endif
endfunction
"setlocal foldexpr=GetPerlFold()
"setlocal foldmethod=expr

hi Folded    ctermfg=darkgrey ctermbg=NONE
hi FoldColumn    ctermfg=darkgrey ctermbg=NONE
set statusline=%<%1*===\ %5*%f%1*%(\ ===\ %4*%h%1*%)%(\ ===\ %4*%m%1*%)%(\ ===\ %4*%r%1*%)\ ===%====\ %2*%b(0x%B)%1*\ ===\ %3*%l,%c%V%1*\ ===\ %5*%P%1*\ ===%0* laststatus=2

"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)%=%(tag:\ %-{GetTagName(line("."))}%)

set list
set listchars=tab:..,trail:-

highlight ExtraWhitespace ctermbg=red guibg=dark
match ExtraWhitespace /\s\+$/
let c_space_errors = 1

"set foldmethod=syntax

map <F10> <Esc>:set expandtab tabstop=4 shiftwidth=4<CR>
map <F9> <Esc>:set noexpandtab tabstop=8 shiftwidth=8<CR>

set path+=.,../include/,./include

execute pathogen#infect()
"highlight SignColumn guibg=red
" let g:gitgutter_sign_removed = '_ '
" let g:gitgutter_sign_added = '+ '
" let g:gitgutter_sign_modified = '~ '

set relativenumber
set shell=/bin/sh

colorscheme my_scheme

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>
nmap <silent> <special> <F3> :NERDTreeFind<RETURN>

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

let NERDTreeIgnore = ['\.o$', '\.a$', '\~$', '\.lo$', '\.la$']
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

" Tell vim to remember certain things when we exit
"  '50  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='50,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>  

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR> 
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR> 
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>   
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR> 


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>   
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  1,2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction

command! PrettyXML call DoPrettyXML()

let g:ctags_path='/usr/bin/ctags'
let g:ctags_statusline=1
let generate_tags=0

"autocmd CursorHold *
"\   call s:_SetTagDisplay()

function! s:_SetTagDisplay()
    let l:tag_name = GetTagName(line("."))
    if !exists('w:tag_name')
        let w:tag_name = ''
    endif
    if (g:ctags_statusline != 0) && ((l:tag_name != w:tag_name) || (&ruler != s:ruler))
        let w:tag_name = l:tag_name
        let s:ruler = &ruler
        if &ruler
            let &statusline='%<%f %(%h%m%r %)%=%{TagName()} %-15.15(%l,%c%V%)%P'
            " Equivalent to default status
            " line with 'ruler' set:
            "
            " '%<%f %h%m%r%=%-15.15(%l,%c%V%)%P'
        else
            let &statusline='%<%f %(%h%m%r %)%=%{TagName()}'
        endif
        " The %(%) pair around the "%h%m%r "
        " is there to suppress the extra
        " space between the file name and
        " the function name when those
        " elements are null.
    endif
    if (g:ctags_title != 0) && (l:tag_name != s:title_tag_name)
        let s:title_tag_name = l:tag_name
        let &titlestring='%t%( %M%)%( (%{expand("%:~:.:h")})%)%( %a%)%='.s:title_tag_name
    endif
endfunction
