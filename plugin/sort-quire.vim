" Public Interface:
" =================
command! SortQuire call s:SortQuire_sort()

" Internal Functions:
" ===================

function! Replace_Requires(requires)
  execute "normal! d%i(:require " . get(a:requires, 0) . "\r"
  normal! k
  let index = 1
  let requires_length = len(a:requires) - 1
  while index < requires_length
    put = get(a:requires, index)
    let index += 1
  endwhile
  normal! j
  execute "normal! i" . get(a:requires, index) . ")"
endfunction

function! Go_To_Require_Line()
  execute "normal! gg/require\<cr>"
endfunction

function! s:SortQuire_sort_clojure()
  let l:current_register = @0
  normal! mt
  call Go_To_Require_Line()
  normal! 0wy%
  let l:require_block = @0
  let reqs = strpart(l:require_block, 10, strlen(l:require_block) - 10)
  let arr_requires = split(reqs, "  ")
  let requires = sort(map(filter(copy(arr_requires), 'v:val != ""'), 'strpart(v:val, 0, strlen(v:val) - 1)'))
  call Replace_Requires(requires)

  call Go_To_Require_Line()
  normal! 0wy%
  execute "normal! \<c-v>\<s-%>="
  normal! `t
  call setreg('0', l:current_register)
endfunction

function! s:SortQuire_sort()
  if &ft == "clojure"
    call s:SortQuire_sort_clojure()
  else
    echo "SortQuire: " . &ft . " not supported :("
  endif
endfunction
