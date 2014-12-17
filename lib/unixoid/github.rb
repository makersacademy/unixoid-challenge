require 'io/console'

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
      @runner.run(%Q{curl -u "#{username}:#{password}" #{GITHUB_URL} -d '{"name": "#{REPO_NAME}"}'})
      self
    end

    def username
      @username ||= ask_for_username
    end

    def password
      @password ||= ask_for_password
    end

    private

    def ask_for_username
      puts "Please enter your Github username:"
      $stdin.gets.chomp
    end
  
    def ask_for_password
      puts "Please enter your Github password:"
      $stdin.noecho(&:gets).chomp
    end
  end
end
