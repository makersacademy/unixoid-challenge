require 'unixoid/challenge'

module Unixoid

  describe Challenge do

    let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }

    before do
      allow(File).to receive(:join).and_return('challenge_spec.rb')
      allow(runner).to receive(:run).and_return("results\n errors")
    end

    describe 'Running specs' do

      let(:command) { 'rspec --order defined -fp challenge_spec.rb' }

      it 'runs the challenge spec' do
        subject.run_specs
        expect(runner).to have_received(:run).with(command, anything)
      end

      it 'outputs the first line to a file' do
        expect(File).to receive(:write).with('unixoid_results.txt', "results\n")
        subject.run_specs 
      end

      it 'provides the result' do
        expect(subject.run_specs).to eq("results\n")
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


