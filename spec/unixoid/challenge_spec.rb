require 'unixoid/challenge'

module Unixoid
  describe Challenge do

    subject { Unixoid::Challenge }

    describe 'run_specs' do
      it 'runs the challenge spec' do
        expect(Unixoid::Runner).to receive(:run).with('rspec challenge_spec.rb')
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
