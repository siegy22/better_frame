$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "better_frame/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "better_frame"
  s.version     = BetterFrame::VERSION
  s.authors     = ["Yves Siegrist"]
  s.email       = ["Elektron1c97@gmail.com"]

  s.summary       = "A better iframe for rails"
  s.description   = "This gem let's you include your rails app inside another website. (using a bit of javascript)"
  s.homepage      = "https://github.com/Elektron1c97/better_frame"
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 11.0"
  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_dependency "rails", ">= 4.2", "< 5.1"
end
