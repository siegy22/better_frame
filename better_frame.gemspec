$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "better_frame/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "better_frame"
  s.version     = BetterFrame::VERSION
  s.authors     = ["Yves Siegrist"]
  s.email       = ["Elektron1c97@gmail.com"]
  s.homepage    = "TODO"

  spec.summary       = "A better iframe for rails"
  spec.description   = "This gem let's you include your rails app inside another website. (using a bit of javascript)"
  spec.homepage      = "https://github.com/Elektron1c97/better_frame"
  spec.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 11.0"
  s.add_dependency "rails", ">= 4.2", "< 5.1"
end
