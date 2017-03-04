# lua-mecab

This is a lua wrapper for [Mecab](http://taku910.github.io/mecab/). It only
supports the `Tagger` class's `parse` method, but generally that's all you
need.

## Building

Build with `make`. 

The `Makefile` assumes `libmecab.so` can be found in `/usr/lib`; if it's somewhere else call make like so:

    make MECAB_SO=/path/to/libmecab.so

and you should be fine.

## Usage

Copy the `lua-mecab.so` file to your lua project and then use it like this:

    mecab = require "lua-mecab"
    parser = mecab:new("") -- you can pass mecab config options here, like "-Owakati"

    print(parser.parse("吾輩は猫である"))

## License

WTFPL, do as you please. 
