class Hylite
  def self.call(*args)
    new(*args).call
  end

  attr_reader :lang

  def initialize(to_highlight, options={})
    self.to_highlight = to_highlight
    self.lang         = 'ruby'
    options.each do |key, value|
      if key =~ /^l/
        self.lang = value
      end
    end
  end

  def call
    require 'coderay'
    code = to_highlight
    code = code.read if code.respond_to? :read
    CodeRay.encode(code, 'ruby', :terminal)
  end

  private

  attr_accessor :to_highlight
  attr_writer   :lang
end
