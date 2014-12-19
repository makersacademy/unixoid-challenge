require 'unixoid/challenge'

module Unixoid

  describe Challenge do

    let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }

    before do
      allow(File).to receive(:join).and_return('challenge_spec.rb')
      allow(runner).to receive(:run).and_return('results')
    end

    describe 'Running specs' do

      let(:command) { 'rspec --out unixoid_results.txt -fp challenge_spec.rb' }

      it 'runs the challenge spec and outputs to a file' do
        subject.run_specs
        expect(runner).to have_received(:run).with(command, anything)
      end

      it 'provides the result' do
        expect(subject.run_specs).to eq('results')
      end

      context 'when the test fails' do

        let(:opts) { { outcodes: [0,1] } }

        it 'does not error as it expects rspec to return exit code 1' do
          subject.run_specs
          expect(runner).to have_received(:run).with(command, opts)
        end
      end
    end  
  end
end


