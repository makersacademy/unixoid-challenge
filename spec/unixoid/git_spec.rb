require 'unixoid/git'

module Unixoid

  describe Git do

    let(:github) { double 'github', username: 'spike01', password: password }
    let(:remote_params) { {username: 'spike01', password: password} }
    let(:password) { 'hustla$$$' }

    subject { Git.new(github) }

    let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }

    let(:create_command) { 'git init' }
    let(:add_command) { 'git add unixoid_results.txt' }
    let(:commit_command) { "git commit -m 'Unixoid submission'" }
    let(:remote_command) { "git remote add origin https://:username::password@github.com/:username/unixoid_submission.git" }
    let(:push_command) { 'git push --force -u origin master' }
    let(:remove_command) { 'git remote rm origin' }
    let(:configure_name_command) { 'git config --global user.name :name' }
    let(:configure_email_command) { 'git config --global user.email :email' }

    let(:file) { 'unixoid_results.txt' }

    context 'running commands' do

      it 'creates a local repo' do
        subject.create_repo
        expect_to_have_run(create_command)
      end

      it 'adds results file' do
        subject.add(file)
        expect_to_have_run(add_command)
      end

      it 'commits changes' do
        subject.commit_results
        expect_to_have_run(commit_command)
      end

      it 'adds remote' do
        subject.add_remote
        expect(runner).to have_received(:run).with(remote_command, params: remote_params)
      end
    end

    context 'when adding a remote and a user enters input with special characters' do

      let(:remote_params) { {username: 'spike01', password: 'pass%20word'} }
      let(:password) { 'pass word' }

      it 'URI encodes the user credentials' do
        subject.add_remote
        expect(runner).to have_received(:run).with(remote_command, params: remote_params)
      end
    end

    it 'force pushes results file' do
      subject.push_results
      expect_to_have_run(push_command)
    end

    it 'removes the remote after push' do
      subject.remove_remote
      expect_to_have_run(remove_command)
    end


    context 'submitting results' do

      let(:commands) { [create_command, add_command, commit_command, push_command, remove_command] }

      it 'adds, commits and pushes in one go' do
        subject.submit(file)
        commands.each do |command| 
          expect_to_have_run(command)
        end
        expect(runner).to have_received(:run).with(remote_command, params: remote_params)
      end
    end

    context 'checking local config' do

      it 'flags when they have no email defined' do
        expect(runner).to receive(:run).with('git config --get user.email', outcodes: [0, 1]).and_return('')
        expect(subject).not_to be_configured 
      end

      it 'flags when they have no name defined' do
        expect(runner).to receive(:run).with('git config --get user.name', outcodes: [0, 1]).and_return('')
        expect(subject).not_to be_configured 
      end

      it 'shows when they have their config set up properly' do
        expect(runner).to receive(:run).with('git config --get user.email', outcodes: [0, 1]).and_return('spike@makersacademy.com')
        expect(runner).to receive(:run).with('git config --get user.name', outcodes: [0, 1]).and_return('Spike Lindsey')
        expect(subject).to be_configured 
      end

      it 'configures Git' do
        subject.configure('Spike Lindsey', 'spike@makersacademy.com')
        expect(runner).to have_received(:run).with(configure_name_command, params: {name: 'Spike Lindsey'})
        expect(runner).to have_received(:run).with(configure_email_command, params: {email: 'spike@makersacademy.com'})
      end
    end
  end
end

def expect_to_have_run(command)
  expect(runner).to have_received(:run).with(command).ordered
end
