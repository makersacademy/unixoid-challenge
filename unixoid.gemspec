Gem::Specification.new do |s|
  s.name        = 'unixoid-challenge'
  s.version     = '0.0.2'
  s.date        = '2014-10-13'
  s.summary     = "Test your command line skills!"
  s.description = "A gem to assess your performance on the unixoid challenge"
  s.authors     = ["Sam Joseph", "Dan Le Dosquet-Bergquist"]
  s.email       = 'sam@makersacademy.com'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(README.md)
  s.add_dependency('rspec', [">= 3"])
  s.homepage    =
    'http://makersacademy.com'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  s.executables = ["unixoid-challenge"]
end
