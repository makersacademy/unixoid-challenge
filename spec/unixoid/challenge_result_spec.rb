require 'unixoid/challenge_result'

describe ChallengeResult do

  subject { ChallengeResult.new(challenge) }

  context 'when all tests pass' do

    let(:challenge) { ".......................\n\nFinished in" }

    it 'indicates that the challenge was completed' do
      expect(subject.status).to eq(:complete)
    end

  end

  context 'when some tests pass' do

    let(:challenge) { "FFF.FFFF.F..FFFFF\n\nFailures" }

    it 'indicates that the challenge was not completed' do
      expect(subject.status).to eq(:attempted)
    end
  end

  context 'when no tests pass' do
    
    let(:challenge) { "FFFFFFFF\n\nFailures" }

    it 'indicates that the challenge has not been attempted' do
      expect(subject.status).to eq(:unattempted)
    end

  end
end
