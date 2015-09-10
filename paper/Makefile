## コンパイルする TeX ファイルの名前（拡張子は除く）
FILE=paper

## pLaTeX のコマンド（入力文字コードは utf8）
LATEX=platex --kanji=utf8 -interaction=nonstopmode -halt-on-error
## upLaTeX を使う人用
##     ※ uplatex は内部データも UTF-8 で処理する LaTeX です。
##       "platex --kanji=utf8" では UTF-8 で読み込んだテキストを
##       内部で EUC-JP に変換するため、一部の特殊な文字は文字化けしますが、
##       uplatex ではちゃんと表示できます（ただし、フォントがあれば）。
##       uplatex を使いたければ、\documentclass のオプションに uplatex を指定してね。
# LATEX=uplatex -interaction=nonstopmode -halt-on-error

.PHONY: all clean

## LaTeX は目次や文献参照、式番号参照などの解決のために複数回のコンパイルが必要です。
all:
	$(LATEX) $(FILE).tex
	-pbibtex $(FILE)
	$(LATEX) $(FILE).tex
	$(LATEX) $(FILE).tex
	dvipdfmx $(FILE).dvi

## make clean で LaTeX が出力する中間ファイルを削除（pdf は削除しない）
clean:
	rm -rf *.acn *.acr *.alg *.aux *.bbl *.blg *.dvi *.fdb_latexmk *.glg *.glo *.gls *.idx *.ilg *.ind *.ist *.lof *.log *.lot *.maf *.mtc *.mtc0 *.nav *.nlo *.out *.pdfsync *.ps *.snm *.synctex.gz *.toc *.vrb *.xdy *.tdo *.fls
