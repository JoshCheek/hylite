require 'hylite'

class Hylite
  class CLI
    def help_screen
      <<-HELP
      Usage: echo '1+1' | hylite

        Syntax Highlighting for Scripters.

        Finds an existing syntax highlighting tool (rouge, coderay, pygments),
        and uses that to highlight the code.

      Options:
        -h        This help screen
        -l LANG   Set the language (defaults to Ruby)

      Examples:
        Set the language to JavaScript
        $ echo 'function alphabet() { console.log("abc"); }' | hylite -l javascript

        Add syntax highlighting to `cat`
        $ cat lib/hylite.rb | hylite

        Highlight sassy style sheets
        $ cat app/assets/stylesheets/site.css.scss | hylite -l scss
      HELP
    end

    def initialize(stdin, argv)
      self.stdin = stdin
      self.argv = argv
    end

    def result
      return help_screen if config[:help]
      ensure_evaluated
      @result
    end

    def success?
      return true if config[:help]
      ensure_evaluated
      errors.none?
    end

    def errors
      config.fetch :errors
    end

    def config
      @config ||= parse(argv)
    end

    private

    attr_accessor :stdin, :argv

    def ensure_evaluated
      return if @evaluated
      @evaluated = true
      @success   = true
      @result    = Hylite.call(stdin, config)
    end

    def parse(args)
      config = {errors: [], help: false, lang: nil}
      args   = args.dup
      while args.any?
        arg = args.shift
        case arg
        when '-h', '--help'
          config[:help] = true
        when '-l', /^--l.*/
          if lang = args.shift
            config[:lang] = lang
          else
            config[:errors] << "Expected a language after #{arg.inspect}"
          end
        else
          config[:errors] << "Unknown argument #{arg.inspect}"
        end
      end
      config
    end
  end
end
