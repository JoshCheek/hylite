require 'open3'
require 'hylite/hyliters'

class Hylite
  module ChooseHyliter
    extend self

    def call(code, lang)
      case
      when rouge_available?    then Rouge.new(code, lang)
      when pygments_available? then Pygments.new(code, lang)
      when coderay_available?  then CodeRay.new(code, lang)
      end
    end

    def self.rouge_available?
      require 'rouge'
    ensure
      return !$!
    end

    def self.pygments_available?
      ENV['PATH'].split(File::PATH_SEPARATOR).any? do |dir|
        File.exist? File.join(dir, 'pygmentize')
      end
    end

    def coderay_available?
      require 'coderay'
    ensure
      return !$!
    end
  end
end
