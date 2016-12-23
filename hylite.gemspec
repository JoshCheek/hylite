$:.push File.expand_path("lib", __dir__)
require "hylite/version"

Gem::Specification.new do |s|
  s.name        = "hylite"
  s.version     = Hylite::VERSION
  s.authors     = ["Josh Cheek"]
  s.email       = ["josh.cheek@gmail.com"]
  s.homepage    = "https://github.com/JoshCheek/hylite"
  s.summary     = %q{Syntax Highlighting for scripters}
  s.description = %q{Provides a simple binary interface and Ruby interface to highlight your code using whatever tools you already have on your machine.}
  s.license     = "WTFPL"

  s.files         = `git ls-files`.split("\n") - Dir['mascots/*']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ['hylite', 'syntax_hilight', 'hilight_syntax']
  s.require_paths = ['lib']

  s.add_development_dependency "rspec",       "~> 3.0"
  s.add_development_dependency "rouge",       "~> 2.0"
  s.add_development_dependency "coderay",     "~> 1.0"
  s.add_development_dependency "ultraviolet", "~> 1.0"
end
