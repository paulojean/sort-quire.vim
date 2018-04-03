" Public Interface:
" =================
command! SortQuire call s:SortQuire_sort()

" Internal Functions:
" ===================

function! s:Select_namespace_sexp()
  normal! ggva(
endfunction

function! s:SortQuire_sort_clojure_fill(items)
  normal! k
  let index = 1
  let items_length = len(a:items) - 1
  while index < items_length
    put = get(a:items, index)
    let index += 1
  endwhile
  normal! j
  execute "normal! i" . get(a:items, index) . ")"
endfunction

function! s:Replace_Requires(requires)
  execute "normal! d%i(:require " . get(a:requires, 0) . "\r"
  call s:SortQuire_sort_clojure_fill(a:requires)
endfunction

function! s:Go_To_Require_Line()
  execute "normal! gg/require\<cr>"
endfunction

function! s:SortQuire_sort_clojure_imports()
  normal! gg
  if search("(:import \[(|[\]")
    normal y%
    let l:import_block = @0
    let imps = strpart(l:import_block, 9, strlen(l:import_block) - 8)
    let arr_imports = split(imps, "  ")
    let imports = sort(
      \   map(
      \     map(filter(copy(arr_imports), 'v:val != ""'),
      \                'strpart(v:val, 0, strlen(v:val) - 1)'),
      \     'substitute(v:val, "^ ", "", "")'))

    if len(imports) <= 1
      execute "normal! d%i\r(:import " . get(imports, 0) . ")"
    else
      execute "normal! d%i\r(:import " . get(imports, 0) . "\r"
      call s:SortQuire_sort_clojure_fill(imports)
    endif

    normal! y%
    execute "normal! \<c-v>\<s-%>="
    normal! kf)ld$
  endif
endfunction

function! s:SortQuire_sort_clojure()
  let l:current_register = @"
  if search("(:require [")
    call s:Go_To_Require_Line()
    normal! 0wy%
    let l:require_block = @0
    let reqs = strpart(l:require_block, 10, strlen(l:require_block) - 10)
    let arr_requires = split(reqs, "  ")
    let requires = sort(map(filter(copy(arr_requires), 'v:val != ""'), 'strpart(v:val, 0, strlen(v:val) - 1)'))
    call s:Replace_Requires(requires)

    call s:Go_To_Require_Line()
    normal! 0wy%
    execute "normal! \<c-v>\<s-%>="
  endif

  call s:SortQuire_sort_clojure_imports()

  call s:Select_namespace_sexp()
  normal! =

  if search(')\s\+)')
    %s/)\s\+)/))/g
  endif

  call setreg('"', l:current_register)
endfunction

function! s:SortQuire_sort()
  if &ft == "clojure"
    call s:SortQuire_sort_clojure()
  else
    echo "SortQuire: " . &ft . " not supported :("
  endif
endfunction
