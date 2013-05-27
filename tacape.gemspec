# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tacape/version"

Gem::Specification.new do |s|
  s.name                  = "tacape"
  s.version               = Tacape::Version::STRING
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9"
  s.authors               = ["Lucas Martins"]
  s.email                 = ["lucasmartins@railsnapraia.com"]
  #s.homepage              = "http://rubygems.org/gems/tacape"
  s.summary               = "A command-line tool that gathers some years of personal crafting."
  s.description           = s.summary
  s.license               = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "i18n"
  s.add_dependency "thor"
  s.add_dependency "notifier"
  s.add_dependency "os"

  s.add_development_dependency "rspec"
  s.add_development_dependency "test_notifier"
  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-nav"
end
