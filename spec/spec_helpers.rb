module SpecHelpers
  def highlighted_tokens(ansi_string)
    ansi_string.scan(/\e.*?m|[^\e]+/).map do |token|
      token[0] == "\e" ? :color : token
    end
  end
end

class Untouchable < BasicObject
  def initialize(name)
    @nme = name
  end
  def method_missing(method_name, *)
    ::Kernel.raise "#{@name} should not have been touched, but received #{method_name.inspect}"
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
  config.fail_fast = true
  config.color     = true
end
