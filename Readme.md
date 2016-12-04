Hylite
======

Syntax Highlighting for scripters.

It has a simple binary-interface and Ruby interface that tries to find a
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


Development
-----------

Assuming a working Ruby development environment (try [chruby](https://github.com/postmodern/chruby) if you don't have one).

```sh
# Install Bundler for dependency management, if you don't already have it
$ gem install bundler

# Tell bundler to install the dev dependencies
$ bundle install

# Run the tests
$ mrspec
```


License
-------

[WTFPL](http://www.wtfpl.net/about/), Just do what the fuck you want to.

NO WARRANTY.
