require 'unixoid/runner'
require 'unixoid/challenge'
require 'unixoid/github'
require 'unixoid/git'

module Unixoid

  def self.run
    github = Github.create_repo
    Challenge.run_specs
    Git.submit(github)
    puts "Challenge Submitted!"
  end
end
