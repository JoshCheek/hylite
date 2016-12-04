RSpec.describe 'hylite' do
  describe 'choosing the highlighter' do
    it 'uses rouge if available'
    it 'uses coderay if rouge is not available'
    it 'uses ultraviolet if rouge and coderay are not available'
    it 'uses pygmentize if rouge, coderay, and ultraviolet are not available'
    it 'tells you how to install these other libs if none of them are available'
  end

  it 'defaults the language to Ruby'
  it 'can be overridden with the :l, :language, or :lmisspelled keywords'
  it 'accepts strings or streams to highlight'
end
