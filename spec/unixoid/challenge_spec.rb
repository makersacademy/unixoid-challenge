require 'unixoid/challenge'

module Unixoid
  describe Challenge do

    subject { Challenge.new }
    
    before do
      allow(File).to receive(:join).and_return('challenge.rb')
    end

    describe 'run_specs' do

      let(:command) { 'rspec challenge.rb > unixoid_results.txt' }

      it 'runs the challenge spec and outputs to a file' do
        expect(Runner).to receive(:run).with(command)
        subject.run_specs
      end

      context 'given a fully correct challenge' do

        it 'indicates a successful result' do
          #expect(subject.run_spec).to eq("Successful result")
        end
      end
    end
  end
end
