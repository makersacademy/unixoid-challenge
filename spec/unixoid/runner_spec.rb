require 'unixoid/runner'

module Unixoid

  describe Runner do

    subject { Runner.new }

    let(:command) { 'echo hello world' }
    let(:error_command) { 'rspec foo' }

    it 'runs a command' do
      expect(subject.run(command)).to match(/hello world/)
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
