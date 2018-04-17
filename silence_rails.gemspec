$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "silence_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "silence_rails"
  s.version     = SilenceRails::VERSION
  s.authors     = ["Pieter van de Bruggen"]
  s.email       = ["pvande@gmail.com"]
  s.homepage    = "https://github.com/pvande/silence_rails"
  s.summary     = "Remove Rails default instrumentation for cleaner logging."
  s.description = "Clear out the Rails default instrumentation to be replaced by your own logging code."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.0.0"

  s.add_development_dependency "sqlite3"
end
