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
if( (maparg( '<leader>c1'  ) == '' ) &&
\   (maparg( '<leader>c2'  ) == '' ) &&
\   (maparg( '<leader>c3'  ) == '' ) &&
\   (maparg( '<leader>c='  ) == '' ) &&
\   (maparg( '<leader>o='  ) == '' ) &&
\   (maparg( '<leader>h1'  ) == '' ) &&
\   (maparg( '<leader>h2'  ) == '' ) &&
\   (maparg( '<leader>vl'  ) == '' ) &&
\   (maparg( '<leader>vi'  ) == '' ) &&
\   (maparg( '<leader>vq'  ) == '' )
\)


"map <leader>p "+gP<CR>
"map <leader>Y "*yy<CR>
"map <leader>P "*p<CR>

map <leader>c1 :%g/^\n\{2,\}/ d<CR>:%s/\s\+$//g<CR>
map <leader>c2 :setlocal expandtab<CR>:retab<CR>
map <leader>c3 :Bufonly<CR>
map <leader>c= :s=\s*\([,;]\)\s*=\1 =g<CR>:let @/ = ""<CR>
map <leader>o= :s=\s*\([*%=+-]\)\s*= \1 =g<CR>:let @/ = ""<CR>
"map <leader>h1 yypVr=o
"map <leader>h2 yypVr-o

" Run command
"call VimuxRunCommand("gcc -v")
" Run last command executed by VimuxRunCommand
map <leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane map
map <leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <leader>vq :VimuxCloseRunner<CR>

map <silent><C-w>b :VimFiler<CR>
map <silent><C-S-Left>  :new<CR>
map <silent><C-S-Right> :tabnew<CR>
map <silent>+ :call LoadTemplate(expand('%:e'))<cr>
map <silent>- :Switch<cr>
map <silent><Leader>w :ChooseWin<cr>
"map <silent><Leader>s :exe "normal cxiw"<CR>
map <silent><F2> :NERDTreeToggle<CR>
map <silent><F3> :TagbarToggle<CR>
"map <silent><Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
"map <silent><Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
map <silent><F6> :SyntasticToggleMode<CR>
imap <silent><F6> <c-o>:SyntasticToggleMode<CR>
map <silent><F12> :exe "normal ysiw".input("entre com o char: ")<CR>

vmap <Enter> <Plug>(EasyAlign)

else
        if ( !has("gui_running") || has("win32") )
                echo "Error:[maps.vim] No Key mapped.\n".
        endif
endif
"
" W Q
"
if ((maparg('W') == '') &&
\   (maparg('Q') == '')
\)
        " shift + s salva direto, sem sair
        map <silent> ? :let g:session_autosave='no'<CR>:q!<CR>
        map  W :set buftype=""<CR>:w!<CR>
        vmap W <esc>:w!<CR>
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

