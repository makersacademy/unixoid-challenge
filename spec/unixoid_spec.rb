require 'unixoid'

describe Unixoid do

  subject { Unixoid.new }

  describe 'Running the entire challenge' do

    let(:challenge) { instance_spy('Challenge') }

    before do
      allow(Unixoid::Challenge).to receive(:new).and_return(challenge)
    end

    it 'runs the spec file' do
      Unixoid.run
      expect(challenge).to have_received(:run_specs)
    end
  end

  # context 'Creating GitHub repo' do
  #
  # end
  #
  # context 'Committing to GitHub' do
  #
  # end

end
