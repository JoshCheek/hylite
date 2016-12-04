require 'open3'
require 'hylite/cli'
require 'spec_helpers'

bin_dir     = File.expand_path '../bin', __dir__
ENV["PATH"] = bin_dir + ":" + ENV["PATH"]

RSpec.describe 'binaries' do
  describe 'hylite' do
    it 'reads code from stdin, highlights it, prints it to stdout' do
      stdout, stderr, status = Open3.capture3 'hylite', stdin_data: '1+1'
      expect(stderr).to be_empty
      expect(status).to be_success
      # Based on CodeRay's formatting of "1+1":
      #                 ["\e[1;34m", "1", "\e[0m", "+", "\e[1;34m", "1", "\e[0m", "\n"]
      expected_tokens = [:color,     "1", :color,  "+", :color,     "1", :color,  "\n"]
      expect(highlighted_tokens stdout).to eq expected_tokens
    end

    context 'when it has an error' do
      it 'prints the error to stderr and exits with a failure code' do
        stdout, stderr, status = Open3.capture3 'hylite -notanarg', stdin_data: '1+1'
        expect(stderr).to include "notanarg"
        expect(status).to_not be_success
        expect(stdout).to be_empty
      end
    end

    describe 'arguments' do
      def unset
        @unset ||= Object.new
      end

      def assert_parses(argv, key, value=unset)
        cli = Hylite::CLI.new("", argv)
        expect(cli.config[key]).to eq value unless value == unset
        cli.config[key]
      end

      it 'prints a help screen for -h / --help and exits successfully' do
        assert_parses [], :help, false
        assert_parses [], :errors, []

        assert_parses ['-h'], :help, true
        assert_parses ['-h'], :errors, []

        assert_parses ['--help'], :help, true
        assert_parses ['--help'], :errors, []
      end

      describe 'language' do
        it 'is not set by default (uses the lib\'s default of Ruby)' do
          assert_parses [], :lang, nil
        end

        it 'can be specified with -l, --language, or --lmisspelled' do
          assert_parses ['-l',           'java'], :lang, 'java'
          assert_parses ['-l',            'cpp'], :lang, 'cpp'
          assert_parses ['--lang',        'cpp'], :lang, 'cpp'
          assert_parses ['--lmisspelled', 'cpp'], :lang, 'cpp'
        end

        it 'sets an error if it sees a language arg without a language' do
          assert_parses ["-l", "cpp"], :errors, []
          errors = assert_parses ["-l"], :errors
          expect(errors.length).to eq 1
          expect(errors[0]).to match /language/
        end

        it 'highlights according to the provided language' do
          ruby = Hylite.call '1', lang: 'ruby'
          css  = Hylite.call '1', lang: 'css'
          expect(ruby).to_not eq css
        end
      end

      it 'sets an error if it sees an arg it doesn\'t understand' do
        errors = assert_parses ["asdf"], :errors
        expect(errors.length).to eq 1
        expect(errors[0]).to match /asdf/
      end

      it 'passes the config, parsed from the arguments, down to the lib' do
        ruby_stdout, ruby_stderr, ruby_status = Open3.capture3 'hylite -l ruby', stdin_data: '1+1'
        css_stdout,  css_stderr,  css_status  = Open3.capture3 'hylite -l css', stdin_data: '1+1'

        expect(ruby_stderr).to     eq css_stderr
        expect(ruby_status).to     eq css_status
        expect(ruby_stdout).to_not eq css_stdout
      end
    end
  end

  describe 'binaries that exist for discoverability' do
    specify 'syntax_hilight: warns you to use hylite, but still works' do
      stdout, stderr, status = Open3.capture3 'syntax_hilight', stdin_data: '1+1'
      expect(stderr).to match /hylite/
      expect(status).to be_success
      expect(stdout).to_not be_empty
    end

    specify 'highlight_syntax: warns you to use hylite, but still works' do
      stdout, stderr, status = Open3.capture3 'highlight_syntax', stdin_data: '1+1'
      expect(stderr).to match /hylite/
      expect(status).to be_success
      expect(stdout).to_not be_empty
    end
  end
end
