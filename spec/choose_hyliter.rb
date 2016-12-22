require 'hylite/choose_hyliter'
require 'rouge'

RSpec.describe 'ChooseHyliter' do
  # ugh, might be better to inject require than this nonsense >.<

  it 'uses rouge if available' do
    hyliter = Hylite::ChooseHyliter.call("#a { color: #FFF; }" , "css")
    expect(hyliter.type).to eq :rouge

    hylited = hyliter.call
    expect(hyliter.call).to include 'FFF'
    expect(hyliter.call).to include "\e[" # an escape sequence in there somewhere
  end


  it 'does not use rouge if it does not support the requested language'


  it 'uses pygments if rouge, isn\'t available' do
    allow(Hylite::ChooseHyliter).to receive(:require).with('rouge').and_raise(LoadError)

    hyliter = Hylite::ChooseHyliter.call("#a { color: #FFF; }" , "css")
    expect(hyliter.type).to eq :pygments

    hylited = hyliter.call
    expect(hyliter.call).to include 'FFF'
    expect(hyliter.call).to include "\e[" # an escape sequence in there somewhere
  end


  it 'uses coderay if rouge and pygmentize aren\'t available' do
    require 'coderay'
    allow(File).to receive(:exist?).and_return(false)
    allow(Hylite::ChooseHyliter).to receive(:require).with('rouge').and_raise(LoadError)
    allow(Hylite::ChooseHyliter).to receive(:require).with('coderay').and_return(true)

    hyliter = Hylite::ChooseHyliter.call("#a { color: #FFF; }" , "css")
    expect(hyliter.type).to eq :coderay

    hylited = hyliter.call
    expect(hyliter.call).to include 'FFF'
    expect(hyliter.call).to include "\e[" # an escape sequence in there somewhere
  end


  it 'tells you how to install these other libs if none of them are available'
end
