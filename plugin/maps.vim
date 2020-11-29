" $Id$
" Name Of File: |n|
"
"  Description: Vim plugin
"
"       Author: Ivan Carlos S. Lopes <lopesivan (at) poli (dot) com (dot) br>
"   Maintainer: Ivan Carlos S. Lopes <lopesivan (at) poli (dot) com (dot) br>
"
"  Last Change: $Date:$
"      Version: $Revision:$
"
"    Copyright: This script is released under the Vim License.
"

if &cp || exists("g:loaded_maps")
        finish
endif

let g:loaded_maps = "v01"
let s:keepcpo  = &cpo
set cpo&vim

" ----------------------------------------------------------------------------

"
" change file with `<leader>'
"
" if( (maparg( '<leader>c1'  ) == '' ) &&
" \   (maparg( '<leader>c2'  ) == '' ) &&
" \   (maparg( '<leader>c3'  ) == '' ) &&
" \   (maparg( '<leader>c='  ) == '' ) &&
" \   (maparg( '<leader>o='  ) == '' ) &&
" \   (maparg( '<leader>h1'  ) == '' ) &&
" \   (maparg( '<leader>h2'  ) == '' )
" \)


"map <leader>p "+gP<CR>
"map <leader>Y "*yy<CR>
"map <leader>P "*p<CR>

map <leader>c1 :%g/^\n\{2,\}/ d<CR>:%s/\s\+$//g<CR>
map <leader>c2 :setlocal expandtab<CR>:retab<CR>
" map <leader>c3 :BufOnly<CR>
" map <leader>c= :s=\s*\([,;]\)\s*=\1 =g<CR>:let @/ = ""<CR>
" map <leader>o= :s=\s*\([*%=+-<>]\)\s*= \1 =g<CR>:let @/ = ""<CR>

"map <leader>h1 yypVr-o
"map <silent><F9> :exe "normal yypVr".input("entre com o char de sublinhar: ")."o"<CR>

map <silent><C-S-Left>  :new<CR>
map <silent><C-S-Right> :tabnew<CR>

map <PageUp>   :tabprevious<CR>
map <PageDown> :tabNext<CR>

"let g:switch_mapping='-'
"map <silent>- :Switch<cr>
"
"map <silent><F2> :NERDTreeToggle<CR>
"map <silent><F3> :TagbarToggle<CR>
"map <silent><F12> :exe "normal ysiw".input("entre com o char: ")<CR>

" SWAP de palavra
map <silent>ç :exe "normal cxiw"<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
"xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
"nmap ga <Plug>(EasyAlign)
vmap <Enter> <Plug>(EasyAlign)

" W Q
"
if ((maparg('W') == '') &&
\   (maparg('Q') == '')
\)
        " shift + s salva direto, sem sair
        map  \ :set buftype=""<CR>:w!<CR>
        map  ?       :let g:session_autosave='no'<CR>:q!<CR>
        map  <c-s>   :sall<CR>

        " map  `q      :let g:session_autosave='no'<CR>:q!<CR>
        " imap `q <esc>:let g:session_autosave='no'<CR>:q!<CR>
        " vmap `q <esc>:let g:session_autosave='no'<CR>:q!<CR>

        " map  `w :set buftype=""<CR>:w!<CR>
        " imap `w <esc>:w!<CR>
        " vmap `w <esc>:w!<CR>

        "map  W :set buftype=""<CR>:w!<CR>
        "vmap W <esc>:w!<CR>
        " 1 - faço /palavra
        " 2 - cw para mudar a palavra
        " 3 - n. faz amudança na proxima palavra  ...
        nn Q n.
        nn Q @='n.'<CR>
        nn Q :normal n.<CR>
else
        if ( !has("gui_running") || has("win32") )
                echo "Error: No Key mapped.\n".
                \    "W, Q are takens and a replacement was not assigned."
        endif
endif
" ----------------------------------------------------------------------------

let &cpo= s:keepcpo
unlet s:keepcpo

" vim: ts=8

