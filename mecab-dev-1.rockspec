package = "mecab"
version = "dev-1"
source = {
   url = "git://github.com/polm/lua-mecab"
}
description = {
   summary = "Wrapper for Mecab Japanese morphological analyzer.",
   detailed = [[
      Wraps mecab so you can tokenize Japanese.
   ]],
   homepage = "https://github.com/polm/lua-mecab", 
   license = "WTFPL" 
}
dependencies = {
   "lua >= 5.1, < 5.4"
}
build = {
  type = "make",
  build_variables = {
    CFLAGS="$(CFLAGS)",
    LIBFLAG="$(LIBFLAG)"
  },
  install_variables = {
    INST_PREFIX="$(PREFIX)",
    INST_LIBDIR="$(LIBDIR)"
    },
}
