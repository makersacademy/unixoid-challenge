require 'forwardable'

module Unixoid

  class Git

    extend Forwardable

    delegate run: :@runner

    attr_reader :username
    
    def initialize(username)
      @username = username
      @runner = Runner.new
    end

    def self.submit(username)
      new(username).submit
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
      run("git remote add origin git@github.com:#{username}/unixoid_submission.git")
    end

    def push_results
      run('git push -u origin master')
    end
  end
end
