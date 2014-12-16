require 'unixoid/runner'

module Unixoid

  describe Runner do

    subject { Runner.new }

    let(:command) { 'ls' }

    it 'runs a command' do
      expect(Kernel).to receive(:system).with(command)
      subject.run(command)
    end
  end
end
