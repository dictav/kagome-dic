dic: dic/ipa.dic dic/juman.dic dic/naist.dic dic/uni.dic

dic/ipa.dic: mecab-master/mecab-ipadic
	_dictool mecab -mecab mecab-master/mecab-ipadic -encoding=eucjp -output dic/ipa.dic

data/ipa: tmp/ipa
	@-rm -r data/ipa
	@-mkdir -p data/ipa
	go-bindata -o data/ipa/bindata.go -nomemcopy -separate -pkg=ipa tmp/ipa

tmp/ipa: mecab-master/mecab-ipadic
	@-rm -r tmp/ipa
	@-mkdir -p tmp/ipa
	_dictool mecab -mecab mecab-master/mecab-ipadic -encoding=eucjp -output tmp/ipa -z=false

dic/juman.dic: mecab-master/mecab-jumandic
	_dictool mecab -mecab mecab-master/mecab-jumandic -output dic/juman.dic

data/juman: tmp/juman
	@-rm -r data/juman
	@-mkdir -p data/juman
	go-bindata -o data/juman/bindata.go -nomemcopy -separate -pkg=juman tmp/juman

tmp/juman: mecab-master/mecab-ipadic
	@-rm -r tmp/juman
	@-mkdir -p tmp/juman
	_dictool mecab -mecab mecab-master/mecab-jumandic -output tmp/juman -z=false

mecab-master:
	curl -o mecab-master.zip https://codeload.github.com/taku910/mecab/zip/master
	unzip mecab-master.zip

dic/naist.dic: mecab-naist-jdic-0.6.3b-20111013
	_dictool mecab -mecab mecab-naist-jdic-0.6.3b-20111013 -encoding=eucjp -output dic/naist.dic

data/naist: tmp/naist
	@-rm -r data/naist
	@-mkdir -p data/naist
	go-bindata -o data/naist/bindata.go -nomemcopy -separate -pkg=naist tmp/naist

tmp/naist: mecab-naist-jdic-0.6.3b-20111013
	@-rm -r tmp/naist
	@-mkdir -p tmp/naist
	_dictool mecab -mecab mecab-naist-jdic-0.6.3b-20111013 -encoding=eucjp -output tmp/naist -z=false

mecab-naist-jdic-0.6.3b-20111013:
	curl -O http://jaist.dl.osdn.jp/naist-jdic/53500/mecab-naist-jdic-0.6.3b-20111013.tar.gz
	tar zxf mecab-naist-jdic-0.6.3b-20111013.tar.gz

dic/uni.dic: unidic-mecab-2.1.2_src
	_dictool mecab -mecab ./unidic-mecab-2.1.2_src -output dic/uni.dic

data/uni: tmp/uni
	@-rm -r data/uni
	@-mkdir -p data/uni
	go-bindata -o data/uni/bindata.go -nomemcopy -separate -pkg=uni tmp/uni

tmp/uni: unidic-mecab-2.1.2_src
	@-rm -r tmp/uni
	@-mkdir -p tmp/uni
	_dictool mecab unidic-mecab-2.1.2_src -output tmp/uni -z=false

unidic-mecab-2.1.2_src:
	curl -O http://iij.dl.osdn.jp/unidic/58338/unidic-mecab-2.1.2_src.zip
	unzip unidic-mecab-2.1.2_src.zip

clean:
	-rm -r mecab-master
	-rm -r mecab-naist-jdic-0.6.3b-20111013
	-rm -r unidic-mecab-2.1.2_src
