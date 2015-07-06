"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/Users/nobutoshiogata/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/Users/nobutoshiogata/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'superbrothers/vim-vimperator'
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
NeoBundle 'grep.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tacahilo/itamae-snippets'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"------------------------------------------------------------------------------------
" NerdCommenter
"------------------------------------------------------------------------------------
let NERDSpaceDelims = 1
nmap cc NERDCommenterToggle
vmap cc NERDCommenterToggle

"------------------------------------------------------------------------------------
" NeoComplCache
"------------------------------------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

let $PYTHONPATH="/Users/nobutoshiogata/.anyenv/envs/pyenv/versions/2.7.9/lib/python2.7/site-packages"
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

"------------------------------------------------------------------------------------
" 基本設定
"------------------------------------------------------------------------------------
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=3
set foldmethod=marker
colorscheme wombat
" マウス使えるように
set ttymouse=xterm2

"------------------------------------------------------------------------------------
" ステータスライン
"------------------------------------------------------------------------------------
set ruler                        " ルーラ表示
set laststatus=2                 " 常に表示

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 ctermfg=cyan
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 ctermfg=white
augroup END

function! GetB()
    let c = matchstr(getline('.'),  '.',  col('.') - 1)
    let c = iconv(c,  &enc,  &fenc)
    return String2Hex(c)
endfunction

func! Nr2Hex(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc

func! String2Hex(str)
    let out = ''
    let ix = 0
    while ix < strlen(a:str)
        let out = out . Nr2Hex(char2nr(a:str[ix]))
        let ix = ix + 1
    endwhile
    return out
endfunc

"------------------------------------------------------------------------------------
" 表示系
"------------------------------------------------------------------------------------
set showmatch                    " 括弧の対応ハイライト
set number                       " 行番号
set list                         " 不可視文字の表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline

" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine term=reverse cterm=reverse

" コマンド実行中は再描画しない
:set lazyredraw

"-------------------------------------------------------------------------------
" インデント
"-------------------------------------------------------------------------------
set autoindent
set cindent
set ts=4 sts=4 sw=4 et
set tabstop=4
set shiftwidth=4

"-------------------------------------------------------------------------------
" 補完・履歴
"-------------------------------------------------------------------------------
set wildmenu                     " コマンド補完を強化
set wildchar=<tab>               " コマンド補完を開始するキー
set wildmode=list:full           " リスト表示，最長マッチ
set history=1000                 " コマンド・検索パターンの履歴数
set complete+=k                  " 補完に辞書ファイル追加

"-------------------------------------------------------------------------------
" タグ関連
"-------------------------------------------------------------------------------
set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags

" tags-and-searchesを使い易くする
nnoremap t  <Nop>
"「飛ぶ」
nnoremap tt  <C-]>
"「進む」
nnoremap tj  ;<C-u>tag<CR>
"「戻る」
nnoremap tk  ;<C-u>pop<CR>
"履歴一覧
nnoremap tl  ;<C-u>tags<CR>

"-------------------------------------------------------------------------------
" 検索
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
" Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

" 選択した文字列を検索
"vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" 選択した文字列を置換
"vnoremap /r "xy;%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>

" s*置換後文字列/g<Cr>でカーソル下のキーワードを置換
"nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'

"-------------------------------------------------------------------------------
" 移動設定
"-------------------------------------------------------------------------------

" カーソルを表示行で移動する。論理行移動は<C-n>,<C-p>
nnoremap h <Left>
nnoremap j gj
nnoremap k gk
nnoremap l <Right>
nnoremap <Down> gj
nnoremap <Up>   gk

" 0, 9で行頭、行末へ
nmap 1 0
nmap 0 ^
nmap 9 $

" insert mode での移動
imap  <C-e> <END>
imap  <C-a> <HOME>
" インサートモードでもC-hjklで移動
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>

" <space>j, <space>kで画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" spaceで次のbufferへ。back-spaceで前のbufferへ
nmap <Space><Space> ;MBEbn<CR>
nmap <BS><BS> ;MBEbp<CR>

" フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 最後に編集された位置に移動
nnoremap gb '[
nnoremap gp ']

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

" 最後に変更されたテキストを選択する
nnoremap gc  `[v`]
vnoremap gc <C-u>normal gc<Enter>
onoremap gc <C-u>normal gc<Enter>

" カーソル位置の単語をyankする
nnoremap vy vawy

" 矩形選択で自由に移動する
set virtualedit+=block

" ビジュアルモード時vで行末まで選択
vnoremap v $h

" C-hjklでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"-------------------------------------------------------------------------------
" カラー関連
"-------------------------------------------------------------------------------

" ターミナルタイプによるカラー設定
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm-256color"
    set t_Co=16
    set t_Sf=[3%dm
    set t_Sb=[4%dm
elseif &term =~ "xterm-color"
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
endif

syntax enable

" Tabキーを空白に変換
set expandtab

" 保存時に行末の空白を除去する
"autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
"autocmd BufWritePre * :%s/\t/  /ge
