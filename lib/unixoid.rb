require 'unixoid/runner'
require 'unixoid/challenge'
require 'unixoid/github'
require 'unixoid/git'

module Unixoid

  def self.run
    puts Challenge.run_specs
    github = Github.create_repo
    Git.submit(github)
  end
end
