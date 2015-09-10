# 住井研論文クラスファイル

## クラスオプション

論文クラスファイルを使うときは，TeX ファイルの先頭で sumiilab-paper.cls を
`\documentclass` で読み込みます．

```latex
\documentclass[OPTIONS]{sumiilab-paper}
```

ここで，`OPTIONS` はクラスオプションであり，論文の体裁などの指定（オプション）をカンマ区切りで並べたものです．
文法は以下のような拡張 BNF で与えられ，ダブルクォーテーションは終端記号を表し，`[...]` は省略可能な部分，
`{...}` は0回以上の繰り返しを意味します．

```
OPTIONS = [ OPT { "," OPT } ]
OPT     = LANGUAGE
        | FONT_SIZE
        | FINAL_DRAFT
        | "uplatex"
        | THEOREM_OPTIONS
        | LISTING_OPTIONS
```

全てのオプションは省略可能であり，省略時はデフォルトの値が使用されます．
基本的に，何も指定せずとも困らないようにデフォルト値が決められていますが，
細かく体裁を制御したいヘビーユーザ向けに色々なオプションを提供しています．

- `THEOREM_OPTIONS` については「定理環境」の節を見て下さい．
- `LISTING_OPTIONS` については「ソースコード」の節を見て下さい．

##### 言語

言語には日本語 `japanese` と英語 `english` のいずれかを指定することができます．(default = `japanese`)

```
LANGUAGE = "japanese" | "english"
```

##### フォントサイズ

文書の標準フォントサイズとして 10pt，11pt，12pt のいずれかを選ぶことができます．(default = `11pt`)

```
FONT_SIZE = "10pt" | "11pt" | "12pt"
```

##### final/draft 指定

final，draft オプションについては標準的な機能なのでググって下さい．(default = `final`)

```
FINAL_DRAFT = "final" | "draft"
```

##### uplatex

日本語を使う場合において，platex コマンドの代わりに uplatex コマンドを使う場合は `uplatex` オプションを指定する必要があります．
デフォルトでは `uplatex` オプションが指定されていない状態です．
英語を使う場合，`uplatex` オプションは無視されます．

## 表紙

表紙に表示される情報は次のマクロで指定します．

- `\title{TITLE}` : 論文の題名（長い時は `\\` で改行できる）
- `\author{ID NAME}` : 著者の学籍番号 `ID` と氏名 `NAME`
- `\date{平成yy年mm月dd日}` : 論文の発表日
- `\paper{平成yy年度 PAPER}` : 論文の種類（`PAPER` = 卒業論文 or 修士論文）
- `\institute{INST}` : 著者の所属（長い時は `\\` で改行できる）
- `\supervisor{NAME}` : 指導教員の氏名 `NAME`
- `\subsupervisor{NAME}` : 副指導教員の氏名 `NAME`

副指導教員の氏名は省略可能であり，省略した場合は表紙に副指導教員が表示されなくなります．
基本的に，論文の著者が設定すべき情報は上記のマクロで全て設定できます．

その他，表紙等に表示される情報をパラメータ化してあります．
これは，将来，変更の必要が生じた時のためのものであり，
普段使うぶんには気にする必要は無いと思います．

- `\@abstractname` : abstract の章のタイトル
- `\@supervisorname` : 指導教員の名前の左に表示されるラベル
- `\@subsupervisorname` : 副指導教員の名前の左に表示されるラベル

また，表紙の体裁を制御するための長さ変数を幾つか定義しています．

- `\titleboxwidth` : 論文題目の囲み枠の横幅
- `\titleboxsep` : 論文題目と囲み枠の縦方向間隔
- `\slp@tpvsep` : 表紙に表示される情報（著者名，日付，所属など）の縦方向間隔

## 定理環境

sumiilab-paper.cls を読み込むと，以下の定理環境が定義されます．

- theorem (定理)
- lemma (補題)
- corollary (系)
- proposition (命題)
- definition (定義)
- example (例)
- assumption (仮定)
- axiom (公理)
- proof (証明)

これらは，例えば，

```latex
\begin{theorem}[定理名]
  定理の内容
\end{theorem}
```

のように使います．（定理名は省略可能で，省略するときは `[...]` を角括弧を含めて消します．）
また，次のように定理環境名の末尾にアスタリスクを付けることで，
定理番号の付かない定理環境を使うことができます．

```latex
\begin{theorem*}[定理名]
  定理の内容
\end{theorem*}
```

加えて，証明終了を表す記号 `\qed` とユーザ定義の定理環境を作るための `\newtheorem` マクロが
定義されます．
これらの定理環境の体裁などを，以下のクラスオプションで指定することができます．

```
THEOREM_OPTIONS = "notheorems"
                | "theoremstyle=" THEOREMSTYLE
```

##### notheorems

`notheorems` オプションを指定すると，定理環境と関連するマクロを定義しません．
sumiilab-paper.cls では theorem.sty を使って定理環境を作っていますが，
どうしても amsthm.sty が使いたい人はこのオプションを指定して，
自力で定理環境を定義して下さい．

##### theoremstyle

`theoremstyle=` には以下のいずれかのオプションを指定することができます．

```
THEOREMSTYLE = "plain"
             | "break"
             | "change"
             | "changebreak"
             | "margin"
             | "marginbreak"
```

それぞれ，theorem.sty の `\theoremstyle` マクロに渡される引数に対応しています．

### ユーザ定義の定理環境

プリアンブルで `\newtheorem{NAME}{LABEL}` とすると，`NAME` という識別子で `LABEL` というラベルの定理環境が作られます．
例えば，`\newtheorem{question}{問}` とした場合，

```latex
\begin{question}[問のタイトル]
  $1 + 1 = 2$ を証明せよ．
\end{question}
```

は「問1.1 (問のタイトル). 1 + 1 = 2 を証明せよ．」とコンパイルされます．
`\newtheorem*{NAME}{LABEL}` とすると，`NAME` という識別子で `LABEL` というラベルの
*定理番号の付かない*定理環境が作られます．
（`NAME` の末尾にアスタリスクを付けると，識別子の命名が統一的なものになって良いと思います．）

## ソースコード

デフォルトでは，ソースコードを TeX 文書中に埋め込むために，
listings.sty というスタイルファイルが読み込まれます．
クラスオプションに `nolistings` を指定すると，読み込まなくなります．

```
LISTING_OPTIONS = nolistings
```

`japanese` オプションが指定されているときは，jlisting.sty が同時に読み込まれます．
