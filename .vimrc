"NeoBundle Scripts-----------------------------
if &compatible
    set nocompatible
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

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
NeoBundle 'fatih/vim-go'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'marcus/rsense'
NeoBundle 'Shougo/vimproc.vim', {
    \   'build' : {
    \     'mac' : 'make -f make_mac.mak'
    \   },
    \ }
NeoBundle 'Shougo/neocomplcache-rsense.vim'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"------------------------------------------------------------------------------------
" indent-guides
"------------------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

"------------------------------------------------------------------------------------
" NerdCommenter
"------------------------------------------------------------------------------------
let NERDSpaceDelims = 1
nmap cc NERDCommenterToggle
vmap cc NERDCommenterToggle

nnoremap <silent><C-e> :NERDTreeToggle<CR>

"------------------------------------------------------------------------------------
" Unite
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
" http://mattn.kaoriya.net/software/vim/20150209151638.htm
"------------------------------------------------------------------------------------
let g:unite_source_history_yank_enable = 1
try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
noremap <C-n> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)
" バッファ一覧
noremap <C-p> :Unite buffer<CR>
" ファイル一覧
noremap <C-b> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"------------------------------------------------------------------------------------
" rsense
"------------------------------------------------------------------------------------
let g:rsenseHome =  "/usr/local/Cellar/rsense/0.3/libexec"
let g:rsenseUseOmniFunc = 1
let g:neocomplcache#sources#rsense#home_directory = '/usr/local/Cellar/rsense/0.3/libexec'

"------------------------------------------------------------------------------------
" NeoComplete
"------------------------------------------------------------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_max_list = 20
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_enable_ignore_case = 1

" .や::を入力したときにオムニ補完が有効になるようにする
if !exists('g:neocomplcache_force_omni_input_patterns')
    let g:neocomplcache_force_omni_input_patterns = {}
endif
let g:neocomplcache_force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"------------------------------------------------------------------------------------
" airline
"------------------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

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
if !has('nvim')
    set ttymouse=xterm2
endif

if (exists('+colorcolumn'))
    set colorcolumn=120
    highlight ColorColumn ctermbg=9
endif

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
set smartindent
set cindent
set ts=2 sts=2 sw=2 et
set tabstop=2
set shiftwidth=2

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
