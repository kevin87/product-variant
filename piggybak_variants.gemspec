$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "piggybak_variants/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "piggybak_variants"
  s.version     = PiggybakVariants::VERSION
  s.authors     = ["Tim Case, Steph Skardal"]
  s.email       = ["piggybak@endpoint.com"]
  s.homepage    = "http://www.piggybak.org"
  s.summary     = "Advanced variant support for Piggybak."
  s.description = "Advanced variant support for Piggybak."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  
  s.add_dependency 'paperclip'
end
