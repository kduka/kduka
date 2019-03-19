# -*- encoding: utf-8 -*-
# stub: rename 1.0.6 ruby lib

Gem::Specification.new do |s|
  s.name = "rename".freeze
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Morshed Alam".freeze]
  s.date = "2017-04-23"
  s.email = ["morshed201@gmail.com".freeze]
  s.homepage = "https://github.com/morshedalam/rename".freeze
  s.licenses = ["MIT".freeze]
  s.rubyforge_project = "rename".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Rename your Rails application using a single command.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<thor>.freeze, [">= 0.19.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<thor>.freeze, [">= 0.19.1"])
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<thor>.freeze, [">= 0.19.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
  end
end
