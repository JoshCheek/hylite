Hylite
======

Syntax Highlighting for scripters.

It has a simple binary-interface and Ruby interface that tries to find a
syntax highlighting tool on your machine and then highlight your code using that tool.

The intent:

1. Allow a script to find and use an existing syntax highlighter without needing
   to add one as a dependency.
2. All syntax highlighting that I've seen have stupidly difficult interfaces
   (often buggy, difficult to discover, the obvious use case requires non-obvious
   configuration which is difficult to discover and has mediocre defaults),
   the intent here is to improve discoverability, have it do the obvious thing
   by default, and choose reasonable defaults so that you rarely have to configure it.
3. If you find ways that it doesn't do this, let me know. Eg I didn't test the
   themes on a light background to make sure they look good there. That might make
   the defaults only work well on dark backgrounds.

If you're not scripting, you'll want to use one of the libraries this tool wraps:

* [Rouge](http://rouge.jneen.net)
* [Coderay](http://coderay.rubychan.de)
* [Pygments](http://pygments.org)


Todo
----

* Allow user to pass a filename as that's a pretty obvious way to use it,
  and that's probably a nicer interface for non-Ruby projects.
* Possibly allow it to guess the default (eg Rouge will do this)


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
