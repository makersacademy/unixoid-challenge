require 'unixoid/runner'
require 'unixoid/challenge'
require 'unixoid/github'
require 'unixoid/git'
require 'unixoid/colorize'
require 'unixoid/challenge_result'

module Unixoid

  def self.run
    results = run_challange
    final_result(results)
    puts "Submitting your results to Makers Academy..."
    push_to_github('challenge_results.txt')
  end

  def self.debug
    puts "Submitting your history to Makers Academy so we can help you debug..."
    create_history_file
    push_to_github('commands.txt')
  end
  private

  class << self
    
    def push_to_github(file)
      github = Github.create_repo
      auth_fail! unless github.authenticated?
      Git.submit(file, github)
      puts "Submitted!"
    end

    def run_challenge
      challenge = Challenge.run_specs
      ChallengeResult.new(challenge)
    end

    def create_history_file
      Runner.run('cp ~/.bash_history commands.txt')
    end

    def final_result(results)
      puts render_results(results)
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
