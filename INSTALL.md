# 環境の構築

## 基礎知識：スーパーユーザ（root ユーザ）

このあとのインストール手順ではコンソールにコマンドを入力して実行する操作が登場しますが、
プロンプトの記号で一般ユーザでの実行なのか、スーパーユーザでの実行なのかを区別します。

- `$` は一般ユーザでの実行（例: `$ ls` は一般ユーザで `ls` を実行）
- `#` はスーパーユーザでの実行（例: `# ls` はスーパーユーザで `ls` を実行）

`$` や `#` 自体はコマンドではないので、入力しません。
一般ユーザからスーパーユーザに切り替えるときは、一般に `su` コマンドを使います。

    $ su
    Password:
    #

ちなみに、パスワードは入力しても画面に表示されないので注意して下さい。
Ubuntu では `su` コマンドの代わりに、`sudo` コマンドを使います。
`sudo` は特定のコマンドだけをスーパーユーザとして実行するためのもので、

    $ sudo ls

のように、一般ユーザで `sudo` の後に実行したいコマンドを書きます。
Ubuntu を使っている人は `#` を `$ sudo` に適宜置き換えて実行して下さい。

## 最低限の環境の構築

今回は、[Debian GNU/Linux](http://www.debian.or.jp/) を前提に解説します。
他の Linux ディストリビューションでは、インストール方法が違うかもしれませんが、そこは自分で何とかして下さい。

### APT パッケージの追加

Debian では、よく使うソフトウェアなどをパッケージという単位でサーバに保存し、管理しています。
そして、コマンドを叩くだけで、それらのパッケージをインストールする仕組みがあります。
デフォルトの設定だと、インストールできるパッケージが限られていて不便なので、増やしておきましょう。

パッケージをダウンロードするためのサーバ情報は `/etc/apt/sources.list` という設定ファイルに
書かれています。これを少し書き換えてみます。

まずは、念の為にバックアップを作っておきます。

    # cd /etc/apt
    # cp sources.list sources.list.bak

スーパーユーザで設定ファイルをいじるときは、バックアップを取るのが常識です。
設定ミスで変な動作をするときは `mv sources.list.bak sources.list` で以前の状態に戻せます。

次に、この設定ファイルの各行の行末に `contrib non-free` というキーワードを追加します。
これで、インストールできるパッケージが増えます。
いちいち、エディタで書き換えてもいいですが、次の2つのコマンドを実行しても同じ事ができます。

    # perl -i -ple '$_ .= " contrib" if /deb/ && !/contrib/' sources.list
    # perl -i -ple '$_ .= " non-free" if /deb/ && !/non-free/' sources.list

そして、最後にサーバからパッケージのリストをダウンロードしてきます。

    # apt-get update

Ubuntu を使っている人は上のコマンドの代わりに `sudo apt-get update` を使います。
ちなみに、`apt-get` は CUI のパッケージ管理ソフトです。

### VMWare Tools のインストール（VMWare を使っている場合）

VMWare のメニューから「VMWare Tools のインストール」を実行すると、VMWare Tools の
tar ball が入ったメディアが CD-ROM としてマウントされます。
`/media/cdrom0` の下に `VMwareTools-****.tar.gz`（`***` は環境依存）
というファイルが存在することを確認し、

    $ tar zxvf /media/cdrom0/VMwareTools-*.tar.gz -C /tmp
    $ cd /tmp/vmware-tools-distrib
    # apt-get install -y gcc make build-essential linux-headers-`uname -r`
    # perl vmware-install.pl
    $ /usr/bin/vmware-user

で VMWare Tools をインストールします。

### TeXLive とその他必要なソフトウェアのインストール

次のコマンドで TeXLive とその他必要なソフトウェアをインストールできます。

    # apt-get install texlive-full texlive-lang-cjk git imagemagick inkscape gimp

### スタイルファイルのインストール

スタイルファイルというのは、便利なマクロなどをまとめた TeX ファイルのことです。
基本的にスタイルファイルは、コンパイルする TeX ファイルと同じディレクトリに置けば読み込まれますが、
新しく論文やスライドを作る度にスタイルファイルをコピーするのは面倒なので、
よく使いそうなものはインストールすると良いです。

住井研究室で、よく使いそうなスタイルファイルについては自動でまとめてインストールするためのインストーラを用意しました。

    $ git clone https://github.com/akabe/sumiilab-tex
    $ cd sumiilab-tex
    # ./install.sh

上のコマンドを実行すると、勝手にスタイルファイルをダウンロードしてきて、インストールしてくれます。
どのようなスタイルファイルがインストールされるかについては、`install.sh` を参照して下さい。

sumiilab-tex リポジトリは時々アップデートされるかもしれません。
そのときは、上記のコマンドを再度実行することで、スタイルファイルの追加や更新が行えます。
（時々、この手順でスタイルファイルの追加・更新を行うことをオススメします。）

### OPAM と OMake のインストール

OMake を使うと、LaTeX ファイルに変更があった時に自動的にビルドしてくれて、便利です。
evince (PDF viewer) を使うと、PDF に変更があると、自動で再読み込みしてくれるので、組み合わせて使うと、大変便利です。
まず、https://opam.ocaml.org/doc/Install.html に従って、OPAM をインストールし、

    # apt-get install libfam-dev
    $ opam install omake

として、OMake をインストールします。

スライドのディレクトリ `slide/` もしくは論文のディレクトリ `paper/` の下で、

    $ omake -P

とすると、自動ビルドしてくれます。
Emacs を使っているのであれば、`M-! omake -P &` とすると便利でしょう。
