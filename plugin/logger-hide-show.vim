command! -nargs=+ Hide :call s:hide_other(<f-args>)
command! HideGoback :call s:goback()
command! HideReset :call s:reset()

function! s:hide_other(...)
    let lines = getbufline(bufname('%'), 1, '$')
    if !exists('b:lines')
        let b:lines = lines
    endif
    normal ggdG
    let filtered = []
    for line in lines
        let matched = 0
        for a in a:000
            let matched = len(matchstr(line, a)) > 0
            if matched
                break
            endif
        endfor
        if matched
            let filtered += [line]
        endif
        call setline(1, filtered)
    endfor
endfunction 

function! s:goback()
    if exists('b:lines')
        normal ggdG
        call setline(1, b:lines)
    endif
endfunction

function! s:reset()
    let b:lines = getbufline(bufname('%'), 1, '$')
endfunction
