require 'unixoid/runner'
require 'unixoid/challenge'

module Unixoid

  def self.run
    Challenge.new.run_specs
      # Rspec.run_tests
      # Github.create_repo
      # Git.create_local_repo
      # Git.push_to_github
  end

  # def print(results)
  #   results.each do |result|
  #     puts result
  #   end
  # end


# legacy

  # def run_spec
  #   Unixoid::Runner.new.run('rspec challenge_spec.rb')
  #   "Successful result"
  # end
  #
  # def run
  #   run_spec
  #   set_up_github
  #   create_git
  #   push_git
  # end

  # def self.run
  #   puts "Running the Unixoid Challenge Assessor ..."
  #   File.write 'unixoid_spec.rb', File.readlines(File.join(File.dirname(__FILE__), '..','spec','unixoid_spec.rb')).join
  #   `rspec unixoid_spec.rb > unixoid_results.txt`
  #   puts 'Please enter your github user name:'
  #   username = gets.chomp
  #   curl = %Q{curl -u #{username} https://api.github.com/user/repos -d '{"name":"unixoid_submission"}'}
  #   %x[#{curl}]
  #   `git init`
  #   `git add unixoid_results.txt`
  #   `git commit -am 'unixoid submission'`
  #   add_remote = "git remote add origin git@github.com:#{username}/unixoid_submission.git"
  #   %x[#{add_remote}]
  #   `git push origin master`
  #   puts "Completed Submission!"
  # end
end
