"==========================================
" Author:  zhuxy
" Base on wklken config
" Version: 8
" BlogPost: http://zhuxy.com
" ReadMe: README.md
" Last_modify: 2014-07-13
" Sections:
"       -> Initial 初始化
"       -> General Settings 基础设置
"       -> Display Settings 展示/排版等界面格式设置
"       -> FileEncode Settings 文件编码设置
"       -> Others 其它配置
"       -> HotKey Settings  自定义快捷键
"       -> FileType Settings  针对文件类型的设置
"       -> Theme Settings  主题设置
"       -> bundle 插件管理和配置项

"==========================================

"==========================================
" Initial 初始化
"==========================================
" 判断操作系统是否是 Windows 还是 Linux 
let g:iswindows = 0
let g:islinux = 0
let g:ismac = 0
let g:iscywin = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

if has("mac") || has("macunix")
    let g:ismac = 1
endif

if has('win32unix')
    let g:iscywin = 1	
endif


" 判断是终端还是 Gvim 
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" Windows Gvim 默认配置
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

"==========================================
" General Settings 基础设置
"==========================================

"以下配置有详细说明，一些特性不喜欢可以直接注解掉

" 修改leader键
let mapleader = ';'
let g:mapleader = ';'

"set guifont=Monaco:h20          " 字体 && 字号

" history存储容量
set history=2000

"检测文件类型
filetype on
"针对不同的文件类型采用不同的缩进格式
filetype indent on
"允许插件
filetype plugin on
"启动自动补全
filetype plugin indent on

set autoread          " 文件修改之后自动载入。
set shortmess=atI       " 启动的时候不显示那个援助索马里儿童的提示

" 备份,到另一个位置. 防止误删, 目前是取消备份
"set backup
"set backupext=.bak
"set backupdir=/tmp/vimbk/


" 取消备份。 视情况自己改
set nobackup
" 关闭交换文件
set noswapfile


"create undo file
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=/tmp/vimundo/
endif

set wildignore=*.swp,*.bak,*.pyc,*.class,.svn
" 突出显示当前行等
set cursorcolumn
set cursorline          " 突出显示当前行


"设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
"好处：误删什么的，如果以前屏幕打开，可以找回
"set t_ti= t_te=


"- 则点击光标不会换,用于复制
"set mouse-=a             " 鼠标暂不启用, 键盘党....
set mouse-=a 

" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
"set selection=exclusive
set selection=inclusive
set selectmode=mouse,key

" No annoying sound on errors
" 去掉输入错误的提示声音
set title                " change the terminal's title
set novisualbell         " don't beep
set noerrorbells         " don't beep
set t_vb=
set tm=500

" Remember info about open buffers on close"
set viminfo^=%

" For regular expressions turn magic on
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================
"
"显示当前的行号列号：
set ruler
""在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

"显示行号：
set number
" 取消换行。
set nowrap

" 括号配对情况,跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

"设置文内智能搜索提示
" 高亮search命中的文本。
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99

syntax on

" 缩进配置

set smartindent   " Smart indent
set autoindent    " 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting

" tab相关变更
set tabstop=4     " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast

" 00x增减数字时使用十进制
set nrformats=


" 相对行号      行号变成相对，可以用 nj  nk   进行跳转 5j   5k 上下跳5行
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

"set langmenu=zh_CN.UTF-8
"set enc=2byte-gb18030
" 下面这句只影响普通模式 (非图形界面) 下的 Vim。
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
" 合并两行中文时，不在中间加空格：
set formatoptions+=B


"==========================================
" others 其它设置
"==========================================
autocmd! bufwritepost _vimrc source % " vimrc文件修改之后自动加载。 windows。
autocmd! bufwritepost .vimrc source % " vimrc文件修改之后自动加载。 linux。

"共享剪贴板  
set clipboard+=unnamed

" 自动补全配置
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class

"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 自动切换目录为当前编辑文件所在目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

" 删除buffer时不关闭窗口
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
 
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
 
    if bufnr("%") == l:currentBufNum
        new
    endif
 
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


"==========================================
" HotKey Settings  自定义快捷键设置
"==========================================

" 主要按键重定义

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" F1 - F12 设置
" F1 废弃这个键,防止调出系统帮助
" F2 行号开关，用于鼠标复制代码用
" F3 file tree
" F4 tagbar
" F5 粘贴模式paste_mode开关,用于有格式的代码粘贴
" F6 代码格式优化化
" F7 编译运行
" F8 C,C++的调试
" F9 代码浏览
" F10 生成tag 
" F11 分割窗口最大化
" F12 vimshell

" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

""为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
    if(&relativenumber == &number)
        set relativenumber! number!
    elseif(&number)
        set number!
    else
        set relativenumber!
    endif
    set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>
"set paste
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
"    paste mode, where you can paste mass data
"    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc

"C，C++ 按F7编译运行
map <F7> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        "        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/tools/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc


"Smart way to move between windows 分屏窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Map ' to : and save a million keystrokes
" ex mode commands made easy 用于快速进入命令行
"nnoremap ' :

" 进入搜索Use sane regexes"
"nnoremap / /\v
"vnoremap / /\v

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz


" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" --------tab/buffer相关

"Use arrow key to change buffer"
noremap <left> :bp<CR>
noremap <right> :bn<CR>
nnoremap <TAB> :tabnext<CR>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" ------- 选中及操作改键

"Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" select all
map <Leader>sa ggVG"

" select block
nnoremap <leader>v V`}

" kj 替换 Esc
"inoremap kj <Esc>

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>


" Quickly close the current window
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>

" sudo save
cmap w!! w !sudo tee > /dev/null %

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"==========================================
" FileType Settings  文件类型设置
"==========================================

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai

" 保存python文件时删除多余空格
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

"==========================================
" Theme Settings  主题设置
"==========================================

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set guioptions-=r
    set guioptions-=L
    set guitablabel=%M\ %t
    set showtabline=1
    set linespace=2
    set noimd
    set t_Co=256
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
                \set guioptions-=m <Bar>
                \set guioptions-=T <Bar>
                \set guioptions-=r <Bar>
                \set guioptions-=L <Bar>
                \else <Bar>
                \set guioptions+=m <Bar>
                \set guioptions+=T <Bar>
                \set guioptions+=r <Bar>
                \set guioptions+=L <Bar>
                \endif<CR>
endif

"设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

"" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline


"==========================================
" bundle 插件管理和配置项
"==========================================
"------------------------------------------- begin of configs --------------------------------------------

"################### 包依赖 #####################
"package dependence:  ctags
"python dependence:  pep8, pyflake
"
"非兼容vi模式。去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
" configure Vundle
filetype off " required! turn off

if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif


"################### 插件管理 ###################

"使用Vundle来管理插件
" vim plugin bundle control, command model
" :BundleInstall     install 安装配置的插件
" :BundleInstall!    update  更新
" :BundleClean       remove plugin not in list 删除本地无用插件
Bundle 'gmarik/vundle'


"################### 基础 ######################

" 多语言语法检查
"Bundle 'scrooloose/syntastic'
"let g:syntastic_error_symbol='>>'
"let g:syntastic_warning_symbol='>'
"let g:syntastic_check_on_open=1
"let g:syntastic_enable_highlighting = 0
"highlight SyntasticErrorSign guifg=white guibg=black


"################### 自动补全 ###################

let g:isUseYouCompleteMe = 0

if g:isUseYouCompleteMe
    " 代码自动补全
    "迄今为止用到的最好的自动VIM自动补全插件
    Bundle 'Valloric/YouCompleteMe'
    "youcompleteme  默认tab  s-tab 和自动补全冲突
    "let g:ycm_key_list_select_completion=['<c-n>']
    let g:ycm_key_list_select_completion = ['<Down>']
    "let g:ycm_key_list_previous_completion=['<c-p>']
    let g:ycm_key_list_previous_completion = ['<Up>']
    let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
    let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
    let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
    "let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开
    let g:ycm_collect_identifiers_from_tags_files = 1

    " 直接触发自动补全
    let g:ycm_key_invoke_completion = '<C-Space>'
    " 黑名单,不启用
    let g:ycm_filetype_blacklist = {
                \ 'tagbar' : 1,
                \ 'gitcommit' : 1,
                \}

endif

" 代码片段快速插入
"Bundle 'SirVer/ultisnips'


"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
" 定义存放代码片段的文件夹 .vim/ultisnips下，使用自定义和默认的，将会的到全局，有冲突的会提示
"let g:UltiSnipsSnippetDirectories=["ultisnips", 'UltiSnips']


Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'

Bundle 'honza/vim-snippets'



"################### 快速编码 ###################

" 快速注释
Bundle 'scrooloose/nerdcommenter'


" 快速加入修改环绕字符
"Bundle 'tpope/vim-surround'
" for repeat -> enhance surround.vim, . to repeat command
"Bundle 'tpope/vim-repeat'

let g:isUsetabular = 0
if g:isUsetabular
    " 快速赋值语句对齐
    Bundle 'godlygeek/tabular'
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    " :号也对齐
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    " :号不变
    "nmap <Leader>a: :Tabularize /:\zs<CR>
    "vmap <Leader>a: :Tabularize /:\zs<CR>
endif

"################### 快速移动 ###################

"更高效的移动 [;; + w/fx]
"Bundle 'Lokaltog/vim-easymotion'


" 显示marks - 方便自己进行标记和跳转
" m[a-zA-Z] add mark
" '[a-zA-Z] go to mark
" m<Space>  del all marks
"Bundle "kshenoy/vim-signature"


"################### 快速选中 ###################
let g:isUseterryma = 0
if g:isUseterryma
    " 选中区块
    Bundle 'terryma/vim-expand-region'
    map + <Plug>(expand_region_expand)
    map _ <Plug>(expand_region_shrink)

    " 多光标选中编辑
    Bundle 'terryma/vim-multiple-cursors'
    let g:multi_cursor_use_default_mapping=0
    " Default mapping
    let g:multi_cursor_next_key='<C-m>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'
endif

" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
if has("cscope")
    "设定可以使用 quickfix 窗口来查看 cscope 结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0
    "在当前目录中添加任何数据库
    if filereadable("cscope.out")
        cs add cscope.out
        "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    "set cscopeverbose
    "快捷键设置
    " s: C语言符号  g: 定义     d: 这个函数调用的函数 c: 调用这个函数的函数
    " t: 文本       e: egrep模式    f: 文件     i: include本文件的文件
    nmap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif


"################### 功能相关 ###################

" 文件搜索
Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
            \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
            \ }
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" ctrlp插件1 - 不用ctag进行函数快速跳转
Bundle 'tacahiroy/ctrlp-funky'
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fuu :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1

let g:ctrlp_extensions = ['funky']


" git.  git操作还是习惯命令行,vim里面处理简单diff编辑操作
"Bundle 'tpope/vim-fugitive'
" :gdiff  :gstatus :gvsplit
"nnoremap <leader>ge :gdiff<cr>

" 同git diff,实时展示文件中修改的行
" 只是不喜欢除了行号多一列, 默认关闭;gs时打开
Bundle 'airblade/vim-gitgutter'
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0
nnoremap <leader>gs :GitGutterToggle<CR>

" edit history, 可以查看回到某个历史状态
"Bundle 'sjl/gundo.vim'
"nnoremap <leader>h :GundoToggle<CR>

"Bundle 'YankRing.vim'
"let g:yankring_history_dir = '/tmp'

"################### 显示增强 ###################

let g:isUserairline = 0
if g:isUserairline
    " 新的airline配置
    Bundle 'bling/vim-airline'
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    "let g:airline_left_sep = '▶'
    "let g:airline_left_alt_sep = '❯'
    "let g:airline_right_sep = '◀'
    "let g:airline_right_alt_sep = '❮'
    "let g:airline_symbols.linenr = '¶'
    "let g:airline_symbols.branch = '⎇'

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers= 1
    let g:airline#extensions#tabline#tab_min_count = 2
    let g:airline#extensions#tabline#buffer_min_count = 2
    let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
    let g:airline#extensions#tabline#buffer_nr_show = 1
    "let g:airline#extensions#bufferline#enabled = 1
    let g:airline#extensions#branch#enabled = 1
    "let g:airline#extensions#syntastic#enabled = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline_theme = 'badwolf'
    let g:airline_theme_patch_func = 'AirlineThemePatch'
    function! AirlineThemePatch(palette)
    if g:airline_theme == 'badwolf'
      for colors in values(a:palette.inactive)
        let colors[3] = 245
      endfor
    endif
    endfunction
endif

" 状态栏显示buffer
"Bundle 'bling/vim-bufferline'

" 中文帮助
Bundle 'asins/vimcdoc'

" 分割窗口最大化
"Bundle 'ZoomWin'
"nnoremap <F11> <c-w>o

let g:isUserainbow = 0
if g:isUserainbow
    "括号显示增强
    Bundle 'kien/rainbow_parentheses.vim'
    let g:rbpt_colorpairs = [
                \ ['brown',       'RoyalBlue3'],
                \ ['Darkblue',    'SeaGreen3'],
                \ ['darkgray',    'DarkOrchid3'],
                \ ['darkgreen',   'firebrick3'],
                \ ['darkcyan',    'RoyalBlue3'],
                \ ['darkred',     'SeaGreen3'],
                \ ['darkmagenta', 'DarkOrchid3'],
                \ ['brown',       'firebrick3'],
                \ ['gray',        'RoyalBlue3'],
                \ ['black',       'SeaGreen3'],
                \ ['darkmagenta', 'DarkOrchid3'],
                \ ['Darkblue',    'firebrick3'],
                \ ['darkgreen',   'RoyalBlue3'],
                \ ['darkcyan',    'SeaGreen3'],
                \ ['darkred',     'DarkOrchid3'],
                \ ['red',         'firebrick3'],
                \ ]
    let g:rbpt_max = 40
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
endif

" 代码缩进
" https://github.com/nathanaelkane/vim-indent-guides
"Bundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
"hi IndentGuidesOdd  guibg=red   ctermbg=3
"hi IndentGuidesEven guibg=green ctermbg=4
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey

"################### 显示增强-主题 ###################"

"主题 solarized
"Bundle 'altercation/vim-colors-solarized'
" .bashrc  --> export TERM=xterm-256color
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"

"Bundle 'chriskempson/vim-tomorrow-theme'

"colorscheme Tomorrow
"colorscheme Tomorrow-Night
"colorscheme Tomorrow-Blue
"colorscheme Tomorrow-Night-Bright
"colorscheme Tomorrow-Night-Eighties

"主题 molokai
Bundle 'tomasr/molokai'
let g:molokai_original = 1

" theme主题
"set background=dark "light
"colorscheme solarized

"set t_Co=256
"autocmd InsertEnter * se cul

colorscheme molokai
"colorscheme desert
"colorscheme ron

"################### 快速导航 ###################
"目录导航
Bundle 'scrooloose/nerdtree'
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"let NERDTreeDirArrows=0
"let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

"for minibufferexpl
"Bundle 'fholgado/minibufexpl.vim'
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"解决FileExplorer窗口变小问题
"let g:miniBufExplForceSyntaxEnable = 1
"let g:miniBufExplorerMoreThanOne=2
"let g:miniBufExplCycleArround=1

" 默认方向键左右可以切换buffer
"nnoremap <TAB> :MBEbn<CR>
"noremap <leader>bn :MBEbn<CR>
"noremap <leader>bp :MBEbp<CR>
"noremap <leader>bd :MBEbd<CR>

"标签导航
Bundle 'majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" markdown
let g:tagbar_type_markdown = {
            \ 'ctagstype': 'markdown',
            \ 'ctagsbin' : '~/.vim/tools/markdown2ctags.py',
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
            \ 's:sections',
            \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
            \ 's' : 'section',
            \ },
            \ 'sort': 0,
            \ }

"################### Input ###################
"Bundle 'vimim/vimim'
"输入法
":let g:vimim_map='c-/'
":let g:vimim_cloud='sougou' " QQ云输入
":let g:vimim_punctuation=0	" 不用中文标点
":set pastetoggle=<C-H>
":let g:vimim_cloud=-1

"################### 代码 ###################
"Bundle 'wesleyche/SrcExpl'
"nmap <F9> :SrcExplToggle<CR>
"Bundle 'std_c.zip'

"Bundle 'a.vim'
"Bundle 'Align'
"Bundle 'jiangmiao/auto-pairs'


"Bundle 'Shougo/vimproc.vim'
"Bundle 'Shougo/vimshell.vim'
"nmap <F12> :VimShell<CR>

"if !g:iscywin
"	Bundle 'xianyo/TagHighlight'
"	let g:TagHighlightSettings = { 
"			\'EnableCscope': 1, 
"			\'LanguageDetectionMethods': ['Extension', 'FileType'],
"			\'FileTypeLanguageOverrides': {'tagbar': 'all', 'gitcommit' : 'all'},
"			\}
"
"	nmap <F10> :UpdateTypesFile<CR>
"else
"	nmap <F10> :BuildCscopeDatabase<CR>
"endif

"################### 语言相关 ###################

"###### Markdown #########
Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
"markdown to HTML  
nmap md :!~/.vim/tools/markdown.pl % > %.html <CR><CR>
nmap fi :!firefox %.html & <CR><CR>

Bundle 'mrtazz/DoxygenToolkit.vim'


filetype plugin indent on

"------------------------------------------- end of configs --------------------------------------------

