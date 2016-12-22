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
      # From Fish, you can see all styles with:
      # for style in (rougify help style | tail -1 | tr -d ' ' | tr , \n); echo \n===== $style =====; rougify highlight -t $style -l ruby bin/hylite   ; end
      theme     = ::Rouge::Theme.find 'monokai'
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
      # From Fish, you can see all styles with:
      # for style in (pygmentize -L styles | sed -n '/\*/s/[*: ]//gp'); echo \n===== $style =====; pygmentize -f terminal256 -O style=$style -l ruby < lib/hylite.rb ; end
      out, err, status = Open3.capture3(
        'pygmentize',
        '-f', 'terminal256',
        '-O', 'style=monokai',
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
end
