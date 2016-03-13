## コンパイルする TeX ファイルの名前（拡張子は除く）
FILE=slide

PDFLATEX=lualatex -interaction=nonstopmode -halt-on-error

.PHONY: all clean

## LaTeX は目次や文献参照、式番号参照などの解決のために複数回のコンパイルが必要です。
all:
	$(PDFLATEX) $(FILE).tex
	$(PDFLATEX) $(FILE).tex

## make clean で LaTeX が出力する中間ファイルを削除（pdf は削除しない）
clean:
	rm -rf *.acn *.acr *.alg *.aux *.bbl *.blg *.dvi *.fdb_latexmk *.glg *.glo *.gls *.idx *.ilg *.ind *.ist *.lof *.log *.lot *.maf *.mtc *.mtc0 *.nav *.nlo *.out *.pdfsync *.ps *.snm *.synctex.gz *.toc *.vrb *.xdy *.tdo *.fls
