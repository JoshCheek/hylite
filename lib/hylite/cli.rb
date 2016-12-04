module Hylite
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
      @success = true
      require 'coderay'
      @result = CodeRay.encode(code.read, :ruby, :terminal)
    end

    def parse(args)
      config = {errors: [], help: false}
      args.each { |arg| config[:errors] << "Unknown argument #{arg.inspect}" }
      config
    end
  end
end
