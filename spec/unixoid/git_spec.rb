require 'unixoid/git'

module Unixoid

  describe Git do

    let(:username) { 'spike01' }

    subject { Git.new(username) }

    let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }

    let(:create_command) { 'git init' }
    let(:add_command) { 'git add unixoid_results.txt' }
    let(:commit_command) { "git commit -m 'Unixoid submission'" }
    let(:remote_command) { "git remote add origin git@github.com:spike01/unixoid_submission.git" }
    let(:push_command) { 'git push -u origin master' }

    context 'running commands' do

      it 'creates a local repo' do
        subject.create_repo
        expect(runner).to have_received(:run).with(create_command)
      end

      it 'adds results file' do
        subject.add_results
        expect(runner).to have_received(:run).with(add_command)
      end

      it 'commits changes' do
        subject.commit_results
        expect(runner).to have_received(:run).with(commit_command)
      end

      it 'adds remote' do
        subject.add_remote
        expect(runner).to have_received(:run).with(remote_command)
      end

      it 'pushes results file' do
        subject.push_results
        expect(runner).to have_received(:run).with(push_command)
      end

    end

    context 'submitting results' do

      let(:commands) { [create_command, add_command, commit_command, remote_command, push_command] }

      it 'adds, commits and pushes in one go' do
        subject.submit
        commands.each do |command| 
          expect(runner).to have_received(:run).with(command)
        end
      end
    end
  end
end
