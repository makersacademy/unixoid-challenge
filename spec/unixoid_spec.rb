require 'unixoid'

describe Unixoid do

  describe 'Running the entire challenge' do

    let!(:challenge) { class_spy('Unixoid::Challenge').as_stubbed_const }
    let!(:github) { class_spy('Unixoid::Github').as_stubbed_const }
    let!(:git) { class_spy('Unixoid::Git').as_stubbed_const }
    let(:github_instance) { double("github", username: username) }

    let(:username) { 'spike01' }

    context 'when running commands' do

      before do
        allow($stdout).to receive(:puts)
        allow(github).to receive(:create_repo).and_return(github_instance)

        Unixoid.run
      end

      it 'runs the spec file' do
        expect(challenge).to have_received(:run_specs)
      end

      it 'creates a repo on Github' do
        expect(github).to have_received(:create_repo)
      end
      
      it 'creates a local repo' do
        expect(git).to have_received(:submit).with(username)
      end
    end

    #it 'prints beginner friendly messages' do
      #allow(challenge).to receive(:run_specs).and_return("Checking your work")
      #expect { Unixoid.run }.to output(/Checking your work/).to_stdout
    #end

  end


  # context 'Creating GitHub repo' do
  #
  # end
  #
  # context 'Committing to GitHub' do
  #
  # end

end
