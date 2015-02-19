require 'io/console'
require 'json'

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
      parse @runner.run(command, params: {username: username, password: password})
      self
    end

    def username
      @username ||= ask_for_username
    end

    def password
      @password ||= ask_for_password
    end

    def authenticated?
      @response && @response['message'] != "Bad credentials"
    end

    private

    def command
      %Q{curl -u ":username::password" #{GITHUB_URL} -d '{"name": "#{REPO_NAME}"}'}
    end

    def parse(response)
      @response = parse_json(response)
    end

    def parse_json(response)
      begin
        JSON.parse(response)
      rescue JSON::ParseError; end
    end

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
