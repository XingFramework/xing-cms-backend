$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "xing_cms_backend/version"

# Describe your gem and declare its dependencies:
# Gem::Specification.new do |s|
#   s.name        = "xing_cms_backend"
#   s.version     = XingCmsBackend::VERSION
#   s.authors     = ["patriciaho"]
#   s.email       = ["patricia.p.ho@gmail.com"]
#   s.homepage    = "TODO"
#   s.summary     = "TODO: Summary of XingCmsBackend."
#   s.description = "TODO: Description of XingCmsBackend."
#   s.license     = "MIT"

#   s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

#   s.add_dependency "rails", "~> 4.2.5"

#   s.add_development_dependency "pg"
# end

Gem::Specification.new do |spec|
  spec.name                      = "xing_cms_backend"
  #{MAJOR: incompatible}.{MINOR added feature}.{PATCH bugfix}-{LABEL}
  spec.version                   = XingCmsBackend::VERSION
  author_list                    = {
                                     "Patricia Ho" => 'patricia@lrdesign.com',
                                   }
  spec.authors                   = author_list.keys
  spec.email                     = spec.authors.map {|name| author_list[name]}
  spec.summary                   = "Code generator tools for the Xing Framework."
  spec.description               = <<-EndDescription
    The Xing Framework is a hypermedia-enabled Rails + AngularJS web and mobile development platform.
    This gem contains a Rails Engine that adds a CMS backend to Xing Application Base.
  EndDescription
  # spec.executables = %w{ xing }

  spec.homepage                  = "http://github.com/#{spec.name.downcase}"
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  # Do this: y$ (on line below to yank it)
  #          @" (to execute that as a command, in the spec.files array
  # !!find lib bin doc spec spec_help -not -regex '.*\.sw.' -type f 2>/dev/null
    #
  # On OSX:
  # find -E lib bin doc spec spec_help -not -regex '.*\.(sw.|keep)' -type f  2>/dev/null
  spec.files                     = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  spec.licenses                  = ["MIT"]
  spec.require_paths             = %w[lib/]
  spec.rubygems_version          = "1.3.5"

  spec.has_rdoc                  = true
  spec.extra_rdoc_files          = Dir.glob("doc/**/*")
  spec.rdoc_options              = %w{--inline-source }
  spec.rdoc_options              += %w{--main doc/README }
  spec.rdoc_options              += ["--title", "#{spec.name}-#{spec.version} Documentation"]

  spec.add_dependency 'xing_backend_token_auth', "~> 0.1.31"
  spec.add_dependency 'xing-backend', "~> 0.0.18"
  spec.add_dependency 'rails', "~> 4.2.1"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "json_spec"
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency "pg"
  # spec.add_dependency 'carrierwave'
  # spec.add_dependency 'rmagick'
  # spec.add_dependency 'rails-observers'

end
