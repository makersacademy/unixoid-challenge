require 'unixoid/runner'
require 'unixoid/challenge'
require 'unixoid/github'
require 'unixoid/git'
require 'unixoid/colorize'
require 'unixoid/challenge_result'

module Unixoid

  def self.run
    create_github_repos
    final_result(run_challenge)
  end

  private

  class << self

    def create_github_repos
      github = Github.create_repo
      auth_fail! unless github.authenticated?
    end

    def run_challenge
      challenge = Challenge.run_specs
      ChallengeResult.new(challenge)
    end

    def check_and_submit
      puts 'Checking and submitting...'
      Git.submit(github)
    end

    def final_result(results)
      puts render_results(results)
      puts 'Challenge Submitted!'
    end

    def auth_fail!
      puts 'Incorrect login details. Please run unixoid-challenge again'.red 
      exit 1
    end

    def render_results(results)
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
end
