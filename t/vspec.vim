set rtp+=..
runtime! plugin/*.vim
runtime! plugin/operator/*.vim
nmap ,sn  <Plug>(operator-rengbang)
vmap ,sn  <Plug>(operator-rengbang)
nmap ,su  <Plug>(operator-rengbang-useprev)
vmap ,su  <Plug>(operator-rengbang-useprev)

describe 'RengBang command'

  before
    new
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
  end

  after
    close!
  end

  it 'can be sequencial numbering'
    %RengBang
    Expect getline(1) == '0. line'
    Expect getline(2) == '1. line'
    Expect getline(3) == '2. line'
    Expect getline(4) == '3. line'
    Expect getline(5) == '4. line'
  end

  it 'can be sequencial numbering with pattern'
    %RengBang \(\d\)\.
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

  it 'can be sequencial numbering with start number'
    %RengBang \(\d\)\. 10
    Expect getline(1) == '110. line'
    Expect getline(2) == '111. line'
    Expect getline(3) == '112. line'
    Expect getline(4) == '113. line'
    Expect getline(5) == '114. line'
  end

  it 'can be sequencial numbering with step number'
    %RengBang \(\d\)\. 10 10
    Expect getline(1) == '110. line'
    Expect getline(2) == '120. line'
    Expect getline(3) == '130. line'
    Expect getline(4) == '140. line'
    Expect getline(5) == '150. line'
  end

  it 'can be sequencial numbering with using first match number'
    %RengBang \(\d*\)\. 10 10 1
    Expect getline(1) == '20. line'
    Expect getline(2) == '30. line'
    Expect getline(3) == '40. line'
    Expect getline(4) == '50. line'
    Expect getline(5) == '60. line'
  end

  it 'can be sequencial numbering with range'
    2,4RengBang
    Expect getline(1) == '10. line'
    Expect getline(2) == '0. line'
    Expect getline(3) == '1. line'
    Expect getline(4) == '2. line'
    Expect getline(5) == '10. line'
  end

end

describe 'RengBangUsePrev command'

  before
    new
    silent put! = '10. line'
    RengBang \(\d\)\.
    %delete
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
  end

  after
    close!
  end

  it 'can be sequencial numbering with using previous settings'
    %RengBangUsePrev
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

  it 'can be sequencial numbering with using previous settings(only set start)'
    %RengBangUsePrev 10
    Expect getline(1) == '110. line'
    Expect getline(2) == '111. line'
    Expect getline(3) == '112. line'
    Expect getline(4) == '113. line'
    Expect getline(5) == '114. line'
  end

  it 'can be sequencial numbering with using previous settings(set start and step)'
    %RengBangUsePrev 10 10
    Expect getline(1) == '110. line'
    Expect getline(2) == '120. line'
    Expect getline(3) == '130. line'
    Expect getline(4) == '140. line'
    Expect getline(5) == '150. line'
  end

  it 'can be sequencial numbering with using previous settings(set start and step and usefirst)'
    %RengBangUsePrev 10 10 1
    Expect getline(1) == '110. line'
    Expect getline(2) == '120. line'
    Expect getline(3) == '130. line'
    Expect getline(4) == '140. line'
    Expect getline(5) == '150. line'
  end

  it 'can be sequencial numbering with using previous settings and range'
    2,4RengBangUsePrev
    Expect getline(1) == '10. line'
    Expect getline(2) == '10. line'
    Expect getline(3) == '11. line'
    Expect getline(4) == '12. line'
    Expect getline(5) == '10. line'
  end

end

describe 'rengbang#rengbang()'

  before
    new
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
  end

  after
    close!
  end

  it 'can be sequencial numbering'
    %call rengbang#rengbang()
    Expect getline(1) == '0. line'
    Expect getline(2) == '1. line'
    Expect getline(3) == '2. line'
    Expect getline(4) == '3. line'
    Expect getline(5) == '4. line'
  end

  it 'can be sequencial numbering with pattern'
    %call rengbang#rengbang('\(\d\)\.')
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

  it 'can be sequencial numbering with start number'
    %call rengbang#rengbang('\(\d\)\.', 10)
    Expect getline(1) == '110. line'
    Expect getline(2) == '111. line'
    Expect getline(3) == '112. line'
    Expect getline(4) == '113. line'
    Expect getline(5) == '114. line'
  end

  it 'can be sequencial numbering with step number'
    %call rengbang#rengbang('\(\d\)\.', 10, 10)
    Expect getline(1) == '110. line'
    Expect getline(2) == '120. line'
    Expect getline(3) == '130. line'
    Expect getline(4) == '140. line'
    Expect getline(5) == '150. line'
  end

  it 'can be sequencial numbering with using first match number'
    %call rengbang#rengbang('\(\d*\)\.', 10, 10, 1)
    Expect getline(1) == '20. line'
    Expect getline(2) == '30. line'
    Expect getline(3) == '40. line'
    Expect getline(4) == '50. line'
    Expect getline(5) == '60. line'
  end

  it 'can be sequencial numbering with range'
    2,4call rengbang#rengbang()
    Expect getline(1) == '10. line'
    Expect getline(2) == '0. line'
    Expect getline(3) == '1. line'
    Expect getline(4) == '2. line'
    Expect getline(5) == '10. line'
  end

end

describe 'rengbang#rengbang_use_prev()'

  before
    new
    silent put! = '10. line'
    RengBang \(\d\)\.
    %delete
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
  end

  after
    close!
  end

  it 'can be sequencial numbering with using previous settings'
    %call rengbang#rengbang_use_prev()
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

  it 'can be sequencial numbering with using previous settings(only set start)'
    %call rengbang#rengbang_use_prev(10)
    Expect getline(1) == '110. line'
    Expect getline(2) == '111. line'
    Expect getline(3) == '112. line'
    Expect getline(4) == '113. line'
    Expect getline(5) == '114. line'
  end

  it 'can be sequencial numbering with using previous settings(set start and step)'
    %call rengbang#rengbang_use_prev(10, 10)
    Expect getline(1) == '110. line'
    Expect getline(2) == '120. line'
    Expect getline(3) == '130. line'
    Expect getline(4) == '140. line'
    Expect getline(5) == '150. line'
  end

  it 'can be sequencial numbering with using previous settings(set start and step and usefirst)'
    %call rengbang#rengbang_use_prev(10, 10, 1)
    Expect getline(1) == '110. line'
    Expect getline(2) == '120. line'
    Expect getline(3) == '130. line'
    Expect getline(4) == '140. line'
    Expect getline(5) == '150. line'
  end

  it 'can be sequencial numbering with using previous settings and range'
    2,4call rengbang#rengbang_use_prev()
    Expect getline(1) == '10. line'
    Expect getline(2) == '10. line'
    Expect getline(3) == '11. line'
    Expect getline(4) == '12. line'
    Expect getline(5) == '10. line'
  end

end

describe '<Plug>(operator-rengbang)'

  before
    new
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
  end

  after
    close!
  end

  it 'can be sequencial numbering in normal mode'
    normal gg,snG
    Expect getline(1) == '0. line'
    Expect getline(2) == '1. line'
    Expect getline(3) == '2. line'
    Expect getline(4) == '3. line'
    Expect getline(5) == '4. line'
  end

  it 'can be sequencial numbering in visual mode'
    normal ggVG,sn
    Expect getline(1) == '0. line'
    Expect getline(2) == '1. line'
    Expect getline(3) == '2. line'
    Expect getline(4) == '3. line'
    Expect getline(5) == '4. line'
  end

end

describe '<Plug>(operator-rengbang-useprev)'

  before
    new
    silent put! = '10. line'
    RengBang \(\d\)\.
    %delete
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
  end

  after
    close!
  end

  it 'can be sequencial numbering with using previous settings in normal mode'
    normal gg,suG
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

  it 'can be sequencial numbering with using previous settings in visual mode'
    normal ggVG,su
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

end

describe 'rengbang#config()'

  before
    new
    silent put! =[
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ '10. line',
      \ ]
    let g:rengbang_default_pattern  = '\(\d\+\)'
    let g:rengbang_default_start    = 0
    let g:rengbang_default_step     = 1
    let g:rengbang_default_usefirst = 0
  end

  after
    close!
  end

  it 'can define default settings'
    call rengbang#config('\(\d\)\.')
    Expect g:rengbang_default_pattern  == '\(\d\)\.'
    Expect g:rengbang_default_start    == 0
    Expect g:rengbang_default_step     == 1
    Expect g:rengbang_default_usefirst == 0
    %call rengbang#rengbang()
    Expect getline(1) == '10. line'
    Expect getline(2) == '11. line'
    Expect getline(3) == '12. line'
    Expect getline(4) == '13. line'
    Expect getline(5) == '14. line'
  end

  it 'can define default settings'
    call rengbang#config('\(\d\)\.', 1)
    Expect g:rengbang_default_pattern  == '\(\d\)\.'
    Expect g:rengbang_default_start    == 1
    Expect g:rengbang_default_step     == 1
    Expect g:rengbang_default_usefirst == 0
    %call rengbang#rengbang()
    Expect getline(1) == '11. line'
    Expect getline(2) == '12. line'
    Expect getline(3) == '13. line'
    Expect getline(4) == '14. line'
    Expect getline(5) == '15. line'
  end

  it 'can define default settings'
    call rengbang#config('\(\d\)\.', 0, 10)
    Expect g:rengbang_default_pattern  == '\(\d\)\.'
    Expect g:rengbang_default_start    == 0
    Expect g:rengbang_default_step     == 10
    Expect g:rengbang_default_usefirst == 0
    %call rengbang#rengbang()
    Expect getline(1) == '10. line'
    Expect getline(2) == '110. line'
    Expect getline(3) == '120. line'
    Expect getline(4) == '130. line'
    Expect getline(5) == '140. line'
  end

  it 'can define default settings'
    call rengbang#config('^\(\d\)', 0, 10, 1)
    Expect g:rengbang_default_pattern  == '^\(\d\)'
    Expect g:rengbang_default_start    == 0
    Expect g:rengbang_default_step     == 10
    Expect g:rengbang_default_usefirst == 1
    %call rengbang#rengbang()
    Expect getline(1) == '10. line'
    Expect getline(2) == '110. line'
    Expect getline(3) == '210. line'
    Expect getline(4) == '310. line'
    Expect getline(5) == '410. line'
  end

end

