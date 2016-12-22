require 'open3'

class Hylite
  class Hyliter
    attr_reader :code, :lang
    def initialize(code, lang)
      @code, @lang = code, lang
    end

    def type
      raise NotImplementedError, 'Subclass should define'
    end
  end

  class Rouge < Hyliter
    def type
      :rouge
    end
    def call
      theme     = ::Rouge::Theme.find 'colorful'
      formatter = ::Rouge::Formatters::Terminal256.new theme
      lexer     = ::Rouge::Lexer.find @lang
      tokens    = lexer.lex @code
      formatter.format(tokens)
    end
  end

  class Pygments < Hyliter
    def type
      :pygments
    end
    def call
      out, err, status = Open3.capture3(
        'pygmentize',
        '-f', 'terminal256',
        '-O', 'style=fruity',
        '-l', lang,
        stdin_data: code
      )
      return out if status.success? && err.empty?
      raise "Uhhh, what led to this, I want to test it but don't know what can cause it / how to mimic it (and therefore what it should do)"
    end
  end

  class CodeRay < Hyliter
    def type
      :coderay
    end
    def call
      ::CodeRay.encode(code, lang, :terminal)
    end
  end

  module ChooseHyliter
    extend self

    def call(code, lang)
      if rouge_available?
        return Rouge.new(code, lang)
      end

      if pygments_available?
        return Pygments.new(code, lang)
      end

      if coderay_available?
        return CodeRay.new(code, lang)
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
