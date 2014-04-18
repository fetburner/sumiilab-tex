#!/bin/bash

exists_sty () {
    kpsewhich "$1" > /dev/null
}

## スーパユーザで実行していない場合はエラー
if [ "$USER" != "root" ]; then
    echo "** ERROR ** Execute by root (use \`su' or \`sudo')"
    exit 1
fi

## スタイルファイルのインストール先を調べる
TEXDIR=`kpsewhich amsmath.sty | sed 's|^\(/.*/tex\)/latex/.*$|\1|'`

if [ "$TEXDIR" = "" ]; then
    echo "** ERROR ** Not found directory for .sty files"
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
if ! exists_sty 'jlisting.sty'; then
    wget 'http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmytexpert%2F26068%2Fjlisting.sty.bz2' -O jlisting.sty.bz2
    bunzip2 jlisting.sty.bz2
    mkdir -p "$TEXDIR/platex/jlisting"
    mv jlisting.sty "$TEXDIR/platex/jlisting"
fi

##
## pxjahyper.sty
##
##   Beamer で作ったスライドを dvipdfmx で PDF に変換すると，PDF の目次が文字化けする
##   ことがあります．プリアンブルで読み込んでおくと，PDF の目次が文字化けを防ぐことができ
##   ます．PDF 自体は pxajahyper の有無にかかわらず，文字化けしないので問題ありませんが，
##   入れておいて損はないでしょう．
##
if ! exists_sty 'pxjahyper.sty'; then
    git clone 'https://github.com/zr-tex8r/PXjahyper'
    mkdir -p "$TEXDIR/platex/pxjahyper"
    mv PXjahyper/pxjahyper.sty "$TEXDIR/platex/pxjahyper"
fi

mktexlsr # TeX 関連ファイルのインデックスを更新

rm -rf "$WORKDIR" # ワーキングディレクトリを削除
