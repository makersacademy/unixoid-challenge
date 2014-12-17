require 'unixoid'

describe Unixoid do

  describe 'Running the entire challenge' do

    let!(:challenge) { class_spy('Unixoid::Challenge').as_stubbed_const }
    let!(:github) { class_spy('Unixoid::Github').as_stubbed_const }

    context 'when running commands' do

      before do
        allow($stdout).to receive(:puts)
        Unixoid.run
      end

      it 'runs the spec file' do
        expect(challenge).to have_received(:run_specs)
      end

      it 'creates a repo on Github' do
        expect(github).to have_received(:create_repo)
      end
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
