RSpec.describe 'binaries' do
  describe 'hylite' do
    it 'reads code from stdin, highlights it, prints it to stdout'
      # $ cat my_code.rb | hylite

    describe 'arguments' do
      it 'prints a help screen for -h / --help'
        # $ hylite --help
      describe 'language' do
        it 'defaults to Ruby'
        # $ cat my_code.c | hylite
        it 'can be specified with -l, --language, or --lmisspelled'
        # $ cat my_code.c | hylite --lang c
      end
    end
  end

  describe 'syntax_hilight' do
    it 'warns you to use hylite, but still works'
  end

  describe 'hilight_syntax' do
    it 'warns you to use hylite, but still works'
  end
end
