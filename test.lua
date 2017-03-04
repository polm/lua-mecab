mecab = require "lua-mecab"

parser = mecab:new("")

for line in io.lines("waga.utf8") do
  print(parser:parse(line))
  break
end
