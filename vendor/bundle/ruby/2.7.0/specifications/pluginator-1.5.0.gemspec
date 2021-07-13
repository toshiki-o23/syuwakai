# -*- encoding: utf-8 -*-
# stub: pluginator 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "pluginator".freeze
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 2.0.0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michal Papis".freeze, "Jordon Bedwell".freeze, "Mose".freeze, "John O'Gara".freeze]
  s.date = "2017-06-12"
  s.email = ["mpapis@gmail.com".freeze, "envygeeks@gmail.com".freeze, "mose@mose.com".freeze, "johnogara@gmail.com".freeze]
  s.homepage = "https://github.com/rvm/pluginator".freeze
  s.licenses = ["LGPL v3".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Rubygems plugin system using Gem.find_files, $LOAD_PATH and $LOADED_FEATURES.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest-reporters>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<minitest-reporters>.freeze, [">= 0"])
  end
end
