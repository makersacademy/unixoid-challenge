require 'unixoid/runner'
require 'unixoid/challenge'
require 'unixoid/github'
require 'unixoid/git'

module Unixoid

  def self.run
    github = Github.create_repo
    return auth_fail unless github.authenticated?

    Challenge.run_specs
    Git.submit(github)
    puts "Challenge Submitted!"
  end

  def self.auth_fail
    puts "Incorrect login details. Please run unixoid-challenge again" 
  end
end
