require 'unixoid'

describe Unixoid do

  describe 'Running the entire challenge' do

    let(:challenge) { instance_spy('Challenge') }

    before do
      allow(Unixoid::Challenge).to receive(:new).and_return(challenge)
    end

    it 'runs the spec file' do
      allow($stdout).to receive(:puts)
      Unixoid.run
      expect(challenge).to have_received(:run_specs)
    end

    it 'prints beginner friendly messages' do
      allow(challenge).to receive(:run_specs).and_return("Checking your work")
      expect { Unixoid.run }.to output(/Checking your work/).to_stdout
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
