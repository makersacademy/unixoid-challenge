class ChallengeResult
  
  STATUSES = [:complete, :attempted, :unattempted]

  PASS_CHAR = '.'
  
  def initialize(challenge)
    @result = parse(challenge)
  end

  def self.status(challenge)
    new(challenge).status
  end

  def status 
    STATUSES.find do |status|
      send("#{status}?")
    end
  end

  private
  
  attr_reader :result

  def complete?
    passed_tests.length == total_tests
  end

  def attempted?
    passed_tests.any?
  end

  def unattempted?
    passed_tests.empty?
  end
  
  def parse(challenge)
    challenge.split("\n").first.chars
  end

  def passed_tests
    result.select { |test| test == PASS_CHAR } 
  end

  def total_tests
    result.length
  end
end
