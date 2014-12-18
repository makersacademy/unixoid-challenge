require 'unixoid/challenge'

module Unixoid

  describe Challenge do

    subject { Challenge.new }

    before do
      allow(File).to receive(:join).and_return('challenge_spec.rb')
      allow(Runner).to receive(:run)
    end

    describe 'Running specs' do

      let(:command) { 'rspec --out unixoid_results.txt -fp challenge_spec.rb' }

      it 'runs the challenge spec and outputs to a file' do
        expect(Runner).to receive(:run).with(command)
        subject.run_specs
      end
    end
  end
end
