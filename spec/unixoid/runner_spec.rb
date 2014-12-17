require 'unixoid/runner'

module Unixoid

  describe Runner do

    subject { Runner.new }

    let(:command) { 'echo hello world' }

    it 'runs a command' do
      expect(subject.run(command)).to match(/hello world/)
    end

    it 'does not output anything to stdout' do
      expect { subject.run(command) }.to_not output.to_stdout
    end
  end
end
