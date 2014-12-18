require 'unixoid/git'

module Unixoid

  describe Git do

    let(:github) { double 'github', username: 'spike01', password: password }
    let(:password) { 'pass' }

    subject { Git.new(github) }

    let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }

    let(:create_command) { 'git init' }
    let(:add_command) { 'git add unixoid_results.txt' }
    let(:commit_command) { "git commit -m 'Unixoid submission'" }
    let(:remote_command) { "git remote add origin https://spike01:pass@github.com/spike01/unixoid_submission.git" }
    let(:push_command) { 'git push --force -u origin master' }
    let(:remove_command) { 'git remote rm origin' }

    context 'running commands' do

      it 'creates a local repo' do
        subject.create_repo
        expect_to_have_run(create_command)
      end

      it 'adds results file' do
        subject.add_results
        expect_to_have_run(add_command)
      end

      it 'commits changes' do
        subject.commit_results
        expect_to_have_run(commit_command)
      end

      it 'adds remote' do
        subject.add_remote
        expect_to_have_run(remote_command)
      end

      context 'when adding a remote and a user enters input with special characters' do

        let(:remote_command) { "git remote add origin https://spike01:pass%20word@github.com/spike01/unixoid_submission.git" }
        let(:password) { 'pass word' }

        it 'URI encodes the user credentials' do
          subject.add_remote
          expect_to_have_run(remote_command)
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

    end

    context 'submitting results' do

      let(:commands) { [create_command, add_command, commit_command, remote_command, push_command, remove_command] }

      it 'adds, commits and pushes in one go' do
        subject.submit
        commands.each do |command| 
          expect_to_have_run(command)
        end
      end
    end

    def expect_to_have_run(command)
      expect(runner).to have_received(:run).with(command)
    end
  end
end
