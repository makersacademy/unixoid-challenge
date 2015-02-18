require 'unixoid/runner'

module Unixoid

  describe Runner do

    let(:command) { 'echo hello world' }
    let(:error_command) { 'rspec foo' }

    it 'runs a command' do
      expect(subject.run(command)).to match(/hello world/)
    end

    context 'with interpolated arguments' do

      let(:args) { { argument: 'hello 99%' } }

      it 'escapes the passed in arguments' do
        expect(subject.run('echo :argument', params: args)).to match(/hello 99%/)
      end
    end

    it 'does not output anything to stdout' do
      expect { subject.run(command) }.to_not output.to_stdout
    end

    it 'does not output errors' do
      expect { subject.run(error_command) }.to_not output.to_stdout
    end

    it 'captures errors' do
      expect(subject.run(error_command)).to be_truthy
    end

    context 'given an expected outcode of 1' do
      let(:opts) { { outcodes: [0, 1] } }
      let(:error_message) { /returned 1\. Expected 0/ }

      it 'does not return an error message as it is expected' do
        expect(subject.run(error_command, opts)).to_not match(error_message)
      end
    end

    describe 'Logging' do

      let(:logfile) { 'testlogfile.log' }

      before do
        stub_const('Unixoid::Runner::LOG_FILE', logfile)
        File.unlink(logfile) if File.exists?(logfile)
      end

      it 'logs output to a file' do
        subject.run(command)
        expect(File.read(logfile)).to match(/hello world/)
      end

      it 'logs errors' do
        subject.run(error_command)
        expect(File.read(logfile)).to match(/ERROR/)
      end
    end
  end
end
