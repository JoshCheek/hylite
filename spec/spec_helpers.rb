module SpecHelpers
  def highlighted_tokens(ansi_string)
    ansi_string.scan(/\e.*?m|[^\e]+/).map do |token|
      token[0] == "\e" ? :color : token
    end
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
  config.fail_fast = true
  config.color     = true
end
