MECAB_SO=/usr/lib/libmecab.so
LIBFLAG=-shared

LUA_DIR=/usr
LUA_LIBDIR=$(LUA_DIR)/lib/lua/5.3

all: lua-mecab.so

lua-mecab.so: lua-mecab.o
	$(CXX) $(LIBFLAG) lua-mecab.o $(MECAB_SO) -o lua-mecab.so

lua-mecab.o: lua-mecab.cpp
	$(CXX) -fPIC -c lua-mecab.cpp -o lua-mecab.o

install:
	mkdir -p $(LUA_LIBDIR)/mecab
	cp lua-mecab.so $(LUA_LIBDIR)/mecab
