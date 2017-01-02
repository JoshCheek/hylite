require 'stringio'
require 'spec_helpers'
require 'hylite'

RSpec.describe 'hylite' do
  it 'invokes whichever hyliter "ChooseHyliter" returns' do
    expect(Hylite::ChooseHyliter).to receive(:call).with("to hylite", 'some lang').and_return(-> { "hylited" })
    hylited = Hylite.new("to hylite", l: "some lang").call
    expect(hylited).to eq "hylited"
  end

  it 'defaults the language to Ruby' do
    expect(Hylite.new(''          ).lang).to     eq 'ruby'
    expect(Hylite.new('', l:   nil).lang).to     eq 'ruby'
    expect(Hylite.new('', l: 'css').lang).to_not eq 'ruby'
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
