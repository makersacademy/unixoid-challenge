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

    def self.submit(file, github)
      new(github).submit(file)
    end

    def submit(file)
      create_repo
      add(file)
      commit_results
      add_remote
      push_results
      remove_remote
    end

    def create_repo
      run('git init')      
    end

    def add(file)
      run("git add #{file}")
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
