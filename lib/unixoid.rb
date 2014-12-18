require 'unixoid/runner'
require 'unixoid/challenge'
require 'unixoid/github'
require 'unixoid/git'
require 'unixoid/colorize'
require 'unixoid/challenge_result'

module Unixoid

  def self.run
    github = Github.create_repo
    return auth_fail unless github.authenticated?

    challenge = Challenge.run_specs
    results = ChallengeResult.new(challenge)

    puts 'Checking and submitting...'
    Git.submit(github)

    puts render_results(results)
    puts 'Challenge Submitted!'
  end

  private

  def self.auth_fail
    puts 'Incorrect login details. Please run unixoid-challenge again'.red 
  end

  def self.render_results(results)
    case results.status
    when :complete
      'Congratulations!'.green
    when :attempted
      %{
Almost there! Feel free to try again and re-submit

The following answers need to be corrected:

#{results.failures.join(", ")}
      }.yellow
    when :unattempted
      'Looks like you have not tried the challenge. Give it a go and resubmit'.red
    end
  end
end
