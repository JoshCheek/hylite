require 'open3'

bin_dir     = File.expand_path '../bin', __dir__
ENV["PATH"] = bin_dir + ":" + ENV["PATH"]

RSpec.describe 'binaries' do
  def format_of(ansi_str)
    # eg CodeRay format "1+1" as:
    # ["\e[1;34m", "1", "\e[0m", "+", "\e[1;34m", "1", "\e[0m", "\n"]
    #  bold blue         off          bold blue        off
    ansi_str.scan(/\e.*?m|[^\e]+/).map do |token|
      token[0] == "\e" ? :color : token
    end
  end

  describe 'hylite' do
    it 'reads code from stdin, highlights it, prints it to stdout' do
      stdout, stderr, status = Open3.capture3 'hylite', stdin_data: '1+1'
      expect(stderr).to be_empty
      expect(status).to be_success
      expect(format_of stdout).to eq [:color, "1", :color, "+", :color, "1", :color, "\n"]
    end

    describe 'arguments' do
      it 'prints a help screen for -h / --help and exits successfully'
        # $ hylite --help
      describe 'language' do
        it 'defaults to Ruby'
        # $ cat my_code.c | hylite
        it 'can be specified with -l, --language, or --lmisspelled'
        # $ cat my_code.c | hylite --lang c
      end

      it 'prints a help screen for unknown args and exits with an error'
    end
  end

  describe 'syntax_hilight' do
    it 'warns you to use hylite, but still works'
  end

  describe 'hilight_syntax' do
    it 'warns you to use hylite, but still works'
  end
end
