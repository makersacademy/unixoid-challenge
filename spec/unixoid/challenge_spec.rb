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
        expect(runner).to have_received(:run).with(command)
      end

      it 'provides the result' do
        expect(subject.run_specs).to eq('results')
      end
    end  
  end
end


