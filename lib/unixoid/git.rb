require 'forwardable'

module Unixoid

  class Git

    extend Forwardable

    delegate run: :@runner
    delegate [:username, :password] => :@github 
    
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
      run("git remote add origin https://#{username}:#{password}@github.com:spike01/unixoid_submission.git")
    end

    def push_results
      run('git push --force -u origin master')
    end
  end
end
