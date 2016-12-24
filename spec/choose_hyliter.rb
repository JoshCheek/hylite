require 'hylite/choose_hyliter'
require 'rouge'

RSpec.describe 'ChooseHyliter' do
  def assert_hilights!(name, unavailable:[])
    Array(unavailable).each do |klass|
      allow(klass).to receive(:new?).and_return(nil)
    end

    hyliter = Hylite::ChooseHyliter.call("#a { color: #FFF; }" , "css")
    expect(hyliter.type).to eq name

    hylited = hyliter.call
    expect(hyliter.call).to include 'FFF'
    expect(hyliter.call).to include "\e[" # an escape sequence in there somewhere
  end

  it 'uses rouge if available' do
    assert_hilights! :rouge
  end

  it 'does not use rouge if it does not support the requested language'

  it 'uses pygments if rouge, isn\'t available' do
    assert_hilights! :pygments, unavailable: [Hylite::Rouge]
  end

  it 'uses coderay if rouge and pygmentize aren\'t available' do
    assert_hilights! :coderay, unavailable: [Hylite::Rouge, Hylite::Pygments]
  end

  it 'tells you how to install these other libs if none of them are available'
end
