require 'unixoid/github'

module Unixoid

  describe Github do

    describe "Creating a remote repo" do

      let(:stdin) { spy('io') }
      let!(:runner) { class_spy('Unixoid::Runner').as_stubbed_const }

      let(:message) { "Please enter your Github username:\n" }

      let(:command) { %Q{curl -u ":username::password" #{github_command}} }
      let(:url) { Github::GITHUB_URL }
      let(:repo) { Github::REPO_NAME }
      let(:github_command) { %Q{#{url} -d '{"name": "#{repo}"}'} }
      let(:auth_params) { {username: 'spike01', password: 'pa$$'} }

      before do
        mock_gets
        suppress_output
        allow(runner).to receive(:run).and_return('{}')
      end

      context 'when fetching user info' do
        it "stores user's github username" do
          subject.create_repo
          expect(subject.username).to eq('spike01')
        end

        it "stores user's github password" do
          subject.create_repo
          expect(subject.password).to eq('pa$$')
        end
      end

      it 'is chainable' do
        subject.create_repo
        expect(subject.create_repo).to eq(subject)
      end

      it 'creates a repo on Github' do
        subject.create_repo
        expect(runner).to have_received(:run).with(command, params: auth_params)
      end

      it 'authenticates' do
        subject.create_repo
        expect(subject).to be_authenticated
      end

      context 'when something goes wrong' do

        let(:error_message) { '{"message": "Bad credentials"}' }

        before do
          allow(runner).to receive(:run).and_return(error_message)
        end

        it 'does not fail silently' do
          subject.create_repo
          expect(subject).to_not be_authenticated 
        end
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
      allow(stdin).to receive(:noecho).and_return('pa$$')
    end
  end
end
