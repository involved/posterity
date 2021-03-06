# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "posterity/version"

Gem::Specification.new do |s|
  s.name        = "posterity"
  s.version     = Posterity::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Bruning"]
  s.email       = ["nicholas@bruning.com.au"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{}

  s.rubyforge_project = "posterity"
  s.add_dependency 'mongoid_publishable', '1.1.0'
  s.add_dependency 'mongoid_slug'
  s.add_dependency 'mongoid_taggable'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
