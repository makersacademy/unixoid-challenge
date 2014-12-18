require 'forwardable'
require 'uri'

module Unixoid

  class Git

    extend Forwardable

    delegate run: :@runner
    
    def initialize(github)
      @github = github
      @runner = Runner.new
    end

    def self.submit(github)
      new(github).submit
    end

    def submit
      create_repo
      add_results
      commit_results
      add_remote
      push_results
      remove_remote
    end

    def create_repo
      run('git init')      
    end

    def add_results
      run('git add unixoid_results.txt')
    end

    def commit_results
      run("git commit -m 'Unixoid submission'")
    end

    def add_remote
      run("git remote add origin https://#{username}:#{password}@github.com/#{username}/unixoid_submission.git")
    end

    def push_results
      run('git push --force -u origin master')
    end

    def remove_remote
      run('git remote rm origin')
    end

    private

    def username
      URI.encode(@github.username)
    end

    def password
      URI.encode(@github.password)
    end
  end
end