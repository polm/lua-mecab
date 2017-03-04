extern "C" {
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
}
#include <string>
#include <string.h>

#include <iostream>
#include <mecab.h>

using namespace std;

// Functions that will create/destroy MyClass instances
static int newTagger(lua_State* L)
{
    int n = lua_gettop(L); // Number of arguments
    if (n != 2)
        return luaL_error(L, "Got %d arguments, expected 2 (class, x)", n);
    // First argument is now a table that represent the class to instantiate
    luaL_checktype(L, 1, LUA_TTABLE);

    lua_newtable(L); // Create table to represent instance

    // Set first argument of new to metatable of instance
    lua_pushvalue(L, 1);
    lua_setmetatable(L, -2);

    // Do function lookups in metatable
    lua_pushvalue(L, 1);
    lua_setfield(L, 1, "__index");

    // Allocate memory for a pointer to to object
    MeCab::Tagger** s = (MeCab::Tagger**)lua_newuserdata(L, sizeof(MeCab::Tagger*));

    const char *x = luaL_checkstring(L, 2);

    *s = MeCab::createTagger(x);
    if (s == NULL) {
      std::cerr << "EXCEPTION: " << MeCab::getTaggerError() << std::endl;
    }

    luaL_getmetatable(L, "Mecab.Tagger");
    lua_setmetatable(L, -2);

    return 1;
}

static MeCab::Tagger* checkTagger(lua_State* L, int index){
    void* t = luaL_checkudata(L, index, "Mecab.Tagger");
    luaL_argcheck(L, t != NULL, index, "tagger expected");
    return *((MeCab::Tagger**) t);
}

static int parseMecab(lua_State* L)
{
    MeCab::Tagger* c = checkTagger(L, 1);

    const char *x = luaL_checkstring(L, 2);
    
    const char *res = c->parse(x);
    lua_pop(L, 1);
    // chop off the last character since it's a newline
    // mecab output ends with a \n, which is good for
    // printf but unexpected in a scripting language
    lua_pushlstring(L, res, strlen(res) - 1);
    return 1;
}

static int destroyTagger(lua_State* L)
{
    MeCab::Tagger* c = checkTagger(L, 1);
    delete c;
    return 0;
}

static const luaL_Reg gTaggerFuncs[] = {
    { "new", newTagger },
    { "parse", parseMecab },
    { NULL, NULL }
};

static const luaL_Reg gTaggerMeta[] = {
    {"__gc", destroyTagger},
    {NULL, NULL}
};

// Registers the class for use in Lua
extern "C" int luaopen_mecab(lua_State *L)
{  
    // Register metatable for user data in registry
    luaL_newmetatable(L, "Mecab.Tagger");
    luaL_setfuncs(L, gTaggerMeta, 0);      
    luaL_setfuncs(L, gTaggerFuncs, 0);      
    lua_pushvalue(L, -1);
    lua_setfield(L, -2, "__index");  

    return 1;
}
