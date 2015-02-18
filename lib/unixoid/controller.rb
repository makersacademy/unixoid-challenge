module Unixoid
  class Controller

    def self.run
      results = run_challenge
      puts "Submitting your results to Makers Academy..."
      push_to_github(Challenge::RESULTS_FILE)
      final_result(results)
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

        git = Git.new(github)
        get_config(git) unless git.configured?

        puts "Submitting..."
        git.submit(file)
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

      def get_config(git)
        puts 'Please enter your full name:'
        name = gets.chomp
        puts 'Please enter your e-mail address:'
        email = gets.chomp
        git.configure(name, email)
      end

      def auth_fail!
        puts 'Incorrect login details. Please run unixoid-challenge again'.red 
        exit 1
      end

      def render_results(results)
        case results.status
        when :complete
          'Congratulations, you have successfully completed the Unixoid Challenge!'.green
        when :attempted
          attempted(results).yellow
        when :unattempted
          puts 'Looks like you have not tried the challenge. Give it a go and then re-submit'.red
          exit 0
        end
      end

      def attempted(results)
        %{
Almost there! Feel free to try again and re-submit

The following answers need to be corrected:

          #{results.failures.join(", ")}
        }
      end
    end
  end
end
