require 'unixoid/github'

module Unixoid

  describe Github do

    subject { Github.new }

    context "creating a remote repo" do

      let(:stdin) { spy('io') }
      let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }      

      let(:message) { "Please enter your Github username:\n" }

      let(:command) { %Q{curl -u spike01 #{github_command}} }
      let(:url) { Github::GITHUB_URL }
      let(:repo) { Github::REPO_NAME }
      let(:github_command) { %Q{#{url} -d '{"name": "#{repo}"}'} }

      before do
        mock_gets
        suppress_output
      end

      it 'asks for a username' do
        expect { subject.create_repo }.to output(message).to_stdout
      end

      it 'takes the username' do
        subject.create_repo
        expect($stdin).to have_received(:gets)
      end

      it 'stores the username' do
        subject.create_repo
        expect(subject.username).to eq('spike01')
      end

      it 'is chainable' do
        expect(subject.create_repo).to eq(subject)
      end

      it 'creates a repo on Github' do
        subject.create_repo
        expect(runner).to have_received(:run).with(command)
      end

      after do
        $stdin = STDIN
      end
    end

    def suppress_output
      allow($stdout).to receive(:puts)
    end

    def mock_gets
      $stdin = stdin
      allow(stdin).to receive(:gets).and_return('spike01')
    end
  end
end
