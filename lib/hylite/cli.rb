module Hylite
  class CLI
    def initialize(code, argv)
      self.code = code
      self.argv = argv
    end

    def result
      require 'coderay'
      CodeRay.encode(code.read, :ruby, :terminal)
    end

    def status
      0
    end

    private

    attr_accessor :code, :argv
  end
end
