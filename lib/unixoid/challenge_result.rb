class ChallengeResult

  STATUSES = [:complete, :attempted, :unattempted]

  PASS_CHAR = '.'

  def initialize(challenge)
    @result = parse(challenge)
  end

  def status 
    STATUSES.find do |status|
      send("#{status}?")
    end
  end

  def failures
    failing_test_numbers.compact
  end

  private

  attr_reader :result

  def complete?
    passes.length == total_tests
  end

  def attempted?
    passes.any?
  end

  def unattempted?
    passes.empty?
  end

  def parse(challenge)
    challenge.chomp("\n").chars
  end

  def passes
    result.select { |test| passed(test) } 
  end

  def passed(test)
    test == PASS_CHAR
  end

  def total_tests
    result.length
  end

  def failing_test_numbers
    @result.map.with_index do |test, index|
      next if passed(test)
      index + 1
    end
  end
end
