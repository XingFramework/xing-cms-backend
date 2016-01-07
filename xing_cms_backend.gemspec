$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "xing_cms_backend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "xing_cms_backend"
  s.version     = XingCmsBackend::VERSION
  s.authors     = ["patriciaho"]
  s.email       = ["patricia.p.ho@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of XingCmsBackend."
  s.description = "TODO: Description of XingCmsBackend."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "pg"
end
