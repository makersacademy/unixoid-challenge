module Unixoid

  class Github
    
    GITHUB_URL = 'https://api.github.com/user/repos'
    REPO_NAME = 'unixoid_submission'

    def initialize
      @runner = Runner.new
    end

    def self.create_repo
      new.create_repo
    end

    def create_repo
      puts "Please enter your Github username:"
      @runner.run(%Q{curl -u #{username} #{GITHUB_URL} -d '{"name": #{REPO_NAME}}'})
    end

    private

    def username
      $stdin.gets.chomp
    end
  end
end
