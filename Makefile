INST_PREFIX = /usr
INST_LIBDIR = $(INST_PREFIX)/lib/lua/5.3

MECAB_SO=/usr/lib/libmecab.so
LIBFLAG=-shared

all: lua-mecab.so

lua-mecab.so: lua-mecab.o
	$(CXX) $(LIBFLAG) lua-mecab.o $(MECAB_SO) -o lua-mecab.so

lua-mecab.o: lua-mecab.cpp
	$(CXX) -fPIC -c lua-mecab.cpp -o lua-mecab.o

install:
	cp lua-mecab.so $(INST_LIBDIR)
