require 'unixoid/challenge'

module Unixoid

  describe Challenge do

    subject { Challenge.new }
    
    before do
      allow(File).to receive(:join).and_return('challenge.rb')
      allow(Runner).to receive(:run)
    end

    describe 'Running specs' do

      let(:command) { 'rspec --out unixoid_results.txt -fp challenge.rb' }

      it 'runs the challenge spec and outputs to a file' do
        expect(Runner).to receive(:run).with(command)
        subject.run_specs
      end

      context 'given a fully correct challenge' do

        let(:message) { "Congratulations, you have completed the unixoid challenge" }

        it 'indicates a successful result' do
          expect(subject.run_specs).to eq(message)
        end
      end
    end

    describe 'Log in to Github' do
      

    end
  end
end
