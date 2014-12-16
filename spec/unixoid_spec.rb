require 'unixoid'

describe Unixoid do

  subject { Unixoid.new }

  describe 'Running the entire challenge' do

    it 'runs the spec file' do
      expect(Unixoid::Challenge).to receive(:run_specs)
      Unixoid.run
    end
  end

  # context 'Running spec file' do
  #
  #   let(:runner) { instance_spy("Unixoid::Runner") }
  #
  #   before do
  #     allow(Unixoid::Runner).to receive(:new).and_return(runner)
  #   end
  #
  #   it 'runs the unixoid spec' do
  #     subject.run_spec
  #     expect(runner).to have_received(:run).with('rspec challenge_spec.rb')
  #   end
  #
  #   context 'given a fully correct challenge' do
  #
  #     it 'indicates a successful result' do
  #       expect(subject.run_spec).to eq("Successful result")
  #     end
  #
  #   end
  #
  # end
  #
  # context 'Creating GitHub repo' do
  #
  # end
  #
  # context 'Committing to GitHub' do
  #
  # end

end
