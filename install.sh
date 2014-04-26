#!/bin/bash

echo_with_dots () {
    str=$1
    for (( i=${#1}; i<50; i++ )); do
        str="$str."
    done
    echo -n $str
}

## コマンドの存在確認を行い，存在しなければエラーで終了
check_command () {
    echo_with_dots "Checking $1 "
    if type "$1" >/dev/null; then
        echo " ok";
    else
        echo " not found"
        echo "** ERROR ** \`$1' command is not found. Install it!"
        exit 1
    fi
}

## スタイルファイルの存在確認を行う
check_sty () {
    echo_with_dots "Checking $1 "
    path=`kpsewhich "$1" 2>/dev/null`
    if [ -e "$path" ]; then
        echo " $path"
        return 0
    else
        echo " not found"
        return 1
    fi
}

## スタイルファイルが正しくインストールされているか確認し，
## うまくいってなければエラーで終了
check_sty_was_installed () {
    if ! check_sty "$1"; then
        echo "** ERROR ** Sorry! Failed to install \`$1'"
        exit 1
    fi
}

## インストールに必要なコマンドの存在確認
check_command wget
check_command bunzip2
check_command git
check_command kpsewhich
check_command mktexlsr

## スタイルファイルのインストール先を調べる
echo_with_dots "Searching sty dir "

TEXDIR=`kpsewhich amsmath.sty | sed 's|^\(/.*/tex\)/latex/.*$|\1|'`
if [ "$TEXDIR" != "" ]; then
    echo " $TEXDIR"
else
    echo " not found"
    exit 1
fi

## スーパユーザで実行していない場合はエラー
if [ "$USER" != "root" ]; then
    echo "** ERROR ** Execute by root (use \`su' or \`sudo')"
    exit 1
fi

## ワーキングディレクトリ
WORKDIR=/tmp/sumiilab-tex
rm -rf "$WORKDIR"   # 古いワーキングディレクトリを削除
mkdir -p "$WORKDIR" # 新しいワーキングディレクトリを作成
cd "$WORKDIR"       # ワーキングディレクトリに移動して作業

##
## jlisting.sty のインストール
##
##   LaTeX でソースコードを書くときは listings.sty というスタイルファイルを使うことが
##   多いです．ただし，コメント等に日本語を含むソースコードはうまく表示できないことがある
##   ので，日本語を使うときは listings.sty と jlisting.sty を併用する必要があります．
##   listings.sty はデフォルトでも入っていますが，jlisting.sty は入っていないので，
##   インストールします．
##
if ! check_sty 'jlisting.sty'; then
    wget 'http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmytexpert%2F26068%2Fjlisting.sty.bz2' -O jlisting.sty.bz2
    bunzip2 jlisting.sty.bz2
    mkdir -p "$TEXDIR/platex/jlisting"
    mv jlisting.sty "$TEXDIR/platex/jlisting"

    check_sty_was_installed 'jlisting.sty' # 正しくインストールされたか確認
fi

##
## pxjahyper.sty
##
##   Beamer で作ったスライドを dvipdfmx で PDF に変換すると，PDF の目次が文字化けする
##   ことがあります．プリアンブルで読み込んでおくと，PDF の目次が文字化けを防ぐことができ
##   ます．PDF 自体は pxjahyper.sty の有無にかかわらず，文字化けしないので，大きな問題は
##   ありませんが，入れておいて損はないでしょう．
##
if ! check_sty 'pxjahyper.sty'; then
    git clone 'https://github.com/zr-tex8r/PXjahyper'
    mkdir -p "$TEXDIR/platex/pxjahyper"
    mv PXjahyper/pxjahyper.sty "$TEXDIR/platex/pxjahyper"

    check_sty_was_installed 'pxjahyper.sty' # 正しくインストールされたか確認
fi

mktexlsr # TeX 関連ファイルのインデックスを更新

rm -rf "$WORKDIR" # ワーキングディレクトリを削除
