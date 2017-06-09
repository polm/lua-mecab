INST_PREFIX = /usr
INST_LIBDIR = $(INST_PREFIX)/lib/lua/5.3

LUA_INCDIR = $(INST_PREFIX)/include

MECAB_LIBS = `mecab-config --libs`
LIBFLAG=-shared

all: lua-mecab.so

clean:
	rm -f lua-mecab.so lua-mecab.o

lua-mecab.so: lua-mecab.o
	$(CXX) $(LIBFLAG) lua-mecab.o $(MECAB_LIBS) -o lua-mecab.so

lua-mecab.o: lua-mecab.cpp
	$(CXX) -I$(LUA_INCDIR) -fPIC -c lua-mecab.cpp -o lua-mecab.o

install:
	cp lua-mecab.so $(INST_LIBDIR)/mecab.so
