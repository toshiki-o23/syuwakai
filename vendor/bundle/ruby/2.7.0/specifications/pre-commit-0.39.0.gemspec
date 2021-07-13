# -*- encoding: utf-8 -*-
# stub: pre-commit 0.39.0 ruby lib

Gem::Specification.new do |s|
  s.name = "pre-commit".freeze
  s.version = "0.39.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shajith Chacko, Josh Lubaway".freeze]
  s.date = "2018-10-22"
  s.description = "A git pre-commit hook written in ruby with a few more tricks up its sleeve".freeze
  s.email = "dontneedmoreemail@example.com".freeze
  s.executables = ["pre-commit".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze, "bin/pre-commit".freeze]
  s.homepage = "http://github.com/jish/pre-commit".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.rdoc_options = ["--main".freeze, "README.md".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A slightly better git pre-commit hook".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<pluginator>.freeze, ["~> 1.5"])
    s.add_development_dependency(%q<benchmark-ips>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_development_dependency(%q<minitest-reporters>.freeze, ["~> 1.0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.49"])
  else
    s.add_dependency(%q<pluginator>.freeze, ["~> 1.5"])
    s.add_dependency(%q<benchmark-ips>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<minitest-reporters>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.49"])
  end
end
