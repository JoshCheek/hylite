require 'stringio'
require 'spec_helpers'
require 'hylite'

RSpec.describe 'hylite' do
  describe 'choosing the highlighter' do
    it 'uses rouge if available'
    it 'uses coderay if rouge is not available'
    it 'uses ultraviolet if rouge and coderay are not available'
    it 'uses pygmentize if rouge, coderay, and ultraviolet are not available'
    it 'tells you how to install these other libs if none of them are available'
  end


  it 'defaults the language to Ruby' do
    h = Hylite.new ''
    expect(h.lang).to eq 'ruby'
  end


  it 'can be overridden with the :l, :language, or :lmisspelled keywords' do
    h = Hylite.new '', l: 'forth'
    expect(h.lang).to eq 'forth'

    h = Hylite.new '', lang: 'forth'
    expect(h.lang).to eq 'forth'

    h = Hylite.new '', lmisspelled: 'forth'
    expect(h.lang).to eq 'forth'
  end

  it 'accepts strings or streams to highlight' do
    # Based on CodeRay's formatting of "1":
    #                 ["\e[1;34m", "1", "\e[0m"]
    expected_tokens = [:color,     "1", :color]
    string          = '1'.freeze
    stream          = StringIO.new string

    expect(highlighted_tokens Hylite.call string).to eq expected_tokens
    expect(highlighted_tokens Hylite.call stream).to eq expected_tokens
  end
end
