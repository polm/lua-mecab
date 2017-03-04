MECAB_SO=/usr/lib/libmecab.so

all: lua-mecab.so

lua-mecab.so: lua-mecab.o
	g++ -shared lua-mecab.o $(MECAB_SO) -o lua-mecab.so

lua-mecab.o: lua-mecab.cpp
	g++ -fPIC -c lua-mecab.cpp -o lua-mecab.o
