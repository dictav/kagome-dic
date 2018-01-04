naist: naist.dic
	go-bindata -o bindata.go -nomemcopy -separate -pkg=data naist.dic

naist.dic: mecab-naist-jdic-0.6.3b-20111013
	go run ./cmd/kagome-dictool mecab mecab-naist-jdic-0.6.3b-20111013 -output naist.dic

mecab-naist-jdic-0.6.3b-20111013:
	curl -O http://jaist.dl.osdn.jp/naist-jdic/53500/mecab-naist-jdic-0.6.3b-20111013.tar.gz
	tar zxf mecab-naist-jdic-0.6.3b-20111013.tar.gz

uni: uni.dic

uni.dic: unidic-mecab-2.1.2_src
	go run main.go uni -mecab ./unidic-mecab-2.1.2_src

unidic-mecab-2.1.2_src:
	curl -O http://iij.dl.osdn.jp/unidic/58338/unidic-mecab-2.1.2_src.zip
	unzip unidic-mecab-2.1.2_src.zip

clean:
	-rm -r mecab-naist-jdic-0.6.3b-20111013
	-rm -r unidic-mecab-2.1.2_src
