FILES := $(shell cat filelist.txt)

.PHONY: html epub

all: html pdf epub mobi

pdf: html
	rm -rf out/black-book.pdf
	pandoc -o out/black-book.pdf --section-divs --pdf-engine=xelatex --toc out/html/black-book.html

html:
	rm -rf out/html && mkdir -p out/html
	cp -r images html/book.css out/html/
	pandoc -o out/html/black-book.html --section-divs --toc --template=html/template.html $(FILES)

epub:
	mkdir -p out
	rm -f out/black-book.epub
	pandoc -o out/black-book.epub --epub-cover-image images/cover.png --toc --epub-chapter-level=2 --data-dir=epub --template=epub/template.html $(FILES)

mobi:
	rm -f out/black-book.mobi
	kindlegen out/black-book.epub -c2
