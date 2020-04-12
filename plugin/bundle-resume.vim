" {{{ bundle-resume.vim 
if exists('g:loaded_bundle_resume')
  finish
endif
" -------------------------------------------------------------------------- }}}
" {{{ Toggle my resume application.
let g:resume_toggle=0
function! ToggleResumeEditor()

 " Do not toggle if resume files are missing.
 let l:resume_toggle_okay=0

 " LaTeX files I use with my resume application. 
 let l:resume=expaned('~/git/resume/resume/resume.tex')
 let l:jobs=expaned('~/git/resume/jobs/jobs.csv')
 let l:jobnbr=expaned('~/git/resume/jobs/jobnbr.tex')
 let l:cover=expland('~/git/resume/letter/coverletter.tex')

 " Open files files in specific splits.
 if !g:resume_toggle
    if !filewritable(l:jobs)
      let l:resume_toggle_okay=1
      edit l:jobs
    endif
    if !filewritable(l:cover)
      let l:resume_toggle_okay=1
      split l:cover
    endif
    if !filewritable(l:jobnbr)
      let l:resume_toggle_okay=1
      split l:jobnbr
    endif
    if l:resume_toggle_okay
      :VideToggleIde
    endif
  end
  let g:resume_toggle =! g:resume_toggle
endfunction
" -------------------------------------------------------------------------- }}}
" {{{ Compile my resume.
function! CompileSS(file)
  if empty(glob(a:file))
    echom a:file . " does not exist."
    return
  endif

  " Create and initialize temporary compiler
  let l:options = {
        \ 'root' : fnamemodify(a:file, ':p:h'),
        \ 'target' : fnamemodify(a:file, ':p:t'),
        \ 'target_path' : fnamemodify(a:file, ':p'),
        \ 'background' : 0,
        \ 'continuous' : 0,
        \ 'callback' : 1,
        \}

  echom l:options.root
  echom l:options.target
  echom l:options.target_path

  let g:vimtex_compiler_enabled = 1
  "let l:compiler = vimtex#compiler#{g:vimtex_compiler_latexmk}#init(l:options)

  call vimtex#echo#status([
        \ ['VimtexInfo', 'vimtex: '],
        \ ['VimtexMsg', 'compiling file ' . l:options.target]])

  "call l:compiler.start()
  call vimtex#compiler#compile_ss()
endfunction
" -------------------------------------------------------------------------- }}}
" Keybindings
nnoremap [r :call CompileSS('~/git/resume/letter/coverletter.tex')<cr>
nnoremap ]r :call ToggleResumeEditor()<cr>
" -------------------------------------------------------------------------- }}}
