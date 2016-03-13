# Git で TeX ファイルを管理する

研究の過程で、論文や証明の内容などを TeX で作って、先生と共有したいことはよくあります。
オンラインストレージを使っても良いですが、Git を使うと便利です。Git で管理すると、変更の履歴が残る他、
同じファイルに違う変更を「同時に」行った場合に、変更をマージする、といった作業をある程度自動的にやってくれます
（手動で行う必要がある部分もありますが、適切に操作すれば、ファイルが破損することは避けられます）。
ここでは、TeX で論文などの TeX ファイルを管理する方法について、ごく簡単に解説します
（Git は複雑で、詳細な解説をここに書くのは不可能なので、他の文献などとあわせて読むと良いです）。

Git 用語の（雑な）解説:

- リポジトリ：ソースコードの変更履歴の情報を集めたデータ・ベース
- リモート・リポジトリ：サーバー上にあるリポジトリで（アクセス権があれば）誰でもアクセスできる
  - プライベート・リポジトリ：登録した人以外はアクセスできない非公開なリポジトリ
  - パブリック・リポジトリ：誰でもアクセスできる公開されたリポジトリ
  - push：ローカル・リポジトリの内容をリモート・リポジトリに反映（アップロード）すること (`git push`)
- ローカル・リポジトリ：ローカル（あなたのパソコンの中）にあるリポジトリ（当たり前だが、外からクセスできない）
  - commit：ローカル・リポジトリにファイルの変更を記録すること (`git commit`)
  - stage：これからコミットするファイルを指定すること (`git add`)

## 1. アカウントを作る

まずは、GitHub か Bitbucket にアカウントを作ります（どちらで作るべきかは、先生に相談して下さい）。
一応、大雑把な比較を載せておきます。がっつり使う気がなければ、どちらも大差ありませんが、
プライベート・リポジトリの数量と共有人数の上限についてだけ気にすると良いと思います。
パブリック・リポジトリの数量は GitHub も Bitbucket も無制限です。

- [GitHub](https://github.com/): 全般的に機能が豊富で使いやすいが、
  プライベート・リポジトリが有料です。
  学生である場合は、https://education.github.com/ から申請することで、
  2年間だけ有料の Micro プラン（$7/月、プライベート・リポジトリは5つまで、共有人数は無制限）を無料で使うことができます。
  申請の際に、大学のメールアドレスと申請理由を書く必要があります。
  申請理由は「大学生です。研究のためにプライベート・リポジトリを使いたい。」みたいなことを英語で2〜3行書くだけです。
- [Bitbucket](https://bitbucket.org/): Git と Mercurial が使える。
  プライベート・リポジトリは無料で数量無制限であるが、全てのプライベート・リポジトリの共有人数の合計は5人が上限です。
  共有人数を増やすのには、お金がかかります。

## 2. Git の初期設定

次のコマンドで、あなたの名前・メルアド・エディタを設定します（エディタは vi でも何でも可）。

    $ git config --global user.name "Taro Yamada"                   # あなたの名前
    $ git config --global user.email "yamada@sf.ecei.tohoku.ac.jp"  # あなたのメルアド
    $ git config --global core.editor emacs                         # エディタは emacs

Git の表示に色つけして欲しい時は、次のコマンドで設定できます。

    $ git config --global color.ui auto        # git の表示に色つけする
    $ git config --global core.pager 'less -R' # pager は less -R

色つけして、表示がおかしくなる時は、次のコマンドで無効化できます。

    $ git config --global color.ui false    # git の表示に色つけしない
    $ git config --global core.pager 'less' # pager は less

いちいち、Enter でスクロールするのがうざい時は pager に空文字列を設定します。
この場合、出力文字列がどんなに長くても、一気にドバっと出力されます。

    $ git config --global core.pager '' # pager を使わない

## 3. ローカル・リポジトリの作成（初期化とコミット）

まずは、Git のローカル・リポジトリを初期化します。

    $ cd sumiilab-tex/slide  # 論文の場合は sumiilab-tex/paper
    $ git init  # ディレクトリを Git リポジトリとして初期化
    Initialized empty Git repository in /home/***/sumiilab-tex/slide/.git/

これで、空のローカル・リポジトリができました。
次に、ローカル・リポジトリにファイルをコミットします。

    $ make clean  # 不要なファイルを予め削除しておく
    $ cp ../.gitignore .
    $ echo "# 私のステキな TeX ファイルたち" > README.md
    $ git add .  # コミットする予定のファイルを index に登録（stage すると言います）
    $ git commit -m "first commit"  # コミットする
    [master (root-commit) 4ba8943] first commit
    5 files changed, 521 insertions(+)
    create mode 100644 .gitignore
    create mode 100644 Makefile
    create mode 100644 README.md
    create mode 100644 beamerthemesumiilab.sty
    create mode 100644 slide.pdf
    create mode 100644 slide.tex

`git commit -m "..."` の `...` の部分に「コミット・メッセージ」つまり「変更の内容」を簡潔に記載します。
長いメッセージを書きたい時は、`git commit` だけ打つと、エディタが起動するので、1行目に変更の内容を簡潔に記載し、
2行目を空行にして、3行目以降に詳細なメッセージを書きます。その後、ファイルを（上書き）保存して、エディタを終了すると、
コミットされます。コミットのログは `git log` で表示できます。

    $ git log
    commit 4ba8943ab2f20c0ae8b843a8d022592187d59da0
    Author: Taro Yamada <yamada@kb.ecei.tohoku.ac.jp>
    Date:   Tue Sep 23 12:29:21 2014 +0900

    first commit

## 4. リモート・リポジトリの作成

GitHub もしくは Bitbucket 上で、リポジトリを作ります（Bitbucket の場合はバージョン管理に Git を選択）。
その際に、パブリック（公開）にするかプライベート（非公開）にするか選び、
空のリポジトリを作成します（README.md、.gitignore や LICENSE ファイルを作成しないこと）。
そして、ローカル・リポジトリに、リモート・リポジトリのアドレスと名前（ここでは origin）を登録しましょう。

    $ git remote add origin https://[username]@github.com/[username]/[repository]

`[username]`、`[repository]` に、それぞれあなたのアカウント名とリポジトリ名を入れます。
例えば、`yamada` というアカウントで、`test42` という名前のリモート・リポジトリを作ったときは、
`git remote add origin https://yamada@github.com/yamada/test42` になります。
このあと、

    $ git push -u origin master

とすると、いままで登録したコミットをリモート・リポジトリにアップロードします。

## 5. Collaborators の登録

プライベート・リポジトリについて、無関係な人には内容を公開せず、
特定の人（例えば、先生）にだけ内容を見えるようにしたい時は、
リポジトリの Collaborators に「特定の人」のアカウントを追加します。
GitHub では、右メニューの "Settings" → "Collaborators" から登録できます。
Bitbucket では、やったこと無いけど、簡単にできるんじゃないでしょうか？

## 6. その後の使い方

あとは、基本的に

1. 新しくファイル（画像とか）を追加したら `git add [filename]` で stage する
2. ファイルの変更したら `git commit -a` もしくは `git commit -a -m "..."` でローカル・リポジトリに登録
3. アップロードするときは `git push`

の流れを繰り返すだけです。ただし、`git push` したときに「マージできない」みたいなエラーが出た場合は
自分以外の collaborator(s) が別な変更をファイルに加えている可能性があるので、

    $ git pull

でリモート・リポジトリの最新の内容をローカル・リポジトリに取り込みます。
そのあと、マージに失敗した箇所を手動で編集していきます。（手動マージについては、ググってください。）
