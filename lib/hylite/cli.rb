require 'hylite'

class Hylite
  class CLI
    def initialize(code, argv)
      self.code = code
      self.argv = argv
    end

    def errors
      config.errors
    end

    def result
      ensure_evaluated
      @result
    end

    def success?
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

    attr_accessor :code, :argv

    def ensure_evaluated
      return if @evaluated
      @evaluated = true
      @success   = true
      @result    = Hylite.call(code.read, config)
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
