Hylite
======

Syntax Highlighting for scripters.

It has a simple binary-interface and shell-interface that tries to find a
syntax highlighting tool on your machine and then highlight your code using that tool.

If you're not scripting, you'll want to use one of the libraries this tool wraps:

* [Rouge](http://rouge.jneen.net)
* [Coderay](http://coderay.rubychan.de)
* [Ultraviolet](https://rubygems.org/gems/ultraviolet)
* [Pygments](http://pygments.org)


Interface
---------

```sh
# Simplest interface
$ cat my_code.rb | hylite

# Highlight other languages
$ cat my_code.c | hylite --lang c
```


License
-------

[WTFPL](http://www.wtfpl.net/about/), Just do what the fuck you want to.

NO WARRANTY.


---------

pygmentize

coderay
  require 'coderay'
  CodeRay.encode code, :ruby, :terminal

rouge
  require 'rouge'
  formatter = Rouge::Formatters::Terminal256.new theme: 'colorful'
  lexer     = Rouge::Lexers::Ruby.new
  tokens    = lexer.lex raw_code
  formatter.format(tokens)

ultraviolet
