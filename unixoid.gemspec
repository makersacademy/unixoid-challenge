Gem::Specification.new do |s|
  s.name        = 'unixoid-challenge'
  s.version     = '0.0.3'
  s.date        = '2014-10-13'
  s.summary     = "Test your command line skills!"
  s.description = "A gem to assess your performance on the unixoid challenge"
  s.authors     = ["Sam Joseph","Dan Le Dosquet-Bergquist", "Leo Allen", "Spike Lindsey"]
  s.email       = 'sam@makersacademy.com'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(README.md challenge_spec.rb)
  s.add_dependency('rspec', ["~> 3"])
  s.add_dependency('cocaine')
  s.homepage    =
    'http://github.com/makersacademy/unixoid-challenge'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  s.executables = ["unixoid-challenge"]
end
