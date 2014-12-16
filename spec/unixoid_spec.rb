require 'unixoid'

describe Unixoid do

  subject { Unixoid.new }

  context 'Running the entire challenge' do

    subject { instance_spy("Unixoid") }

    before do
      allow(Unixoid).to receive(:new).and_return subject 
    end

    it 'runs the spec file' do
      Unixoid.run
      expect(subject).to have_received(:run_spec)
    end
  end

  context 'Running spec file' do

    let(:runner) { instance_spy("Unixoid::Runner") }

    before do
      allow(Unixoid::Runner).to receive(:new).and_return(runner)
    end

    it 'runs the unixoid spec' do
      subject.run_spec
      expect(runner).to have_received(:run).with('rspec challenge_spec.rb')
    end

    context 'given a fully correct challenge' do

      it 'indicates a successful result' do
        expect(subject.run_spec).to eq("Successful result")
      end

    end

  end

  context 'Creating GitHub repo' do

  end

  context 'Committing to GitHub' do

  end

end
