require 'open3'
require 'hylite/hyliters'

class Hylite
  module ChooseHyliter
    extend self
    def call(code, lang)
      Rouge.new?(   code, lang) ||
      Pygments.new?(code, lang) ||
      CodeRay.new?( code, lang)
    end
  end
end
