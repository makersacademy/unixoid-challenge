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

    let(:challenge) { "FFF.FFFF.F\n\nFailures" }

    it 'indicates that the challenge was not completed' do
      expect(subject.status).to eq(:attempted)
    end

    it 'indicates which challenges have failed' do
      expect(subject.failures).to eq([1, 2, 3, 5, 6, 7, 8, 10])
    end
  end

  context 'when no tests pass' do
    
    let(:challenge) { "FFFFFFFF\n\nFailures" }

    it 'indicates that the challenge has not been attempted' do
      expect(subject.status).to eq(:unattempted)
    end

  end
end
