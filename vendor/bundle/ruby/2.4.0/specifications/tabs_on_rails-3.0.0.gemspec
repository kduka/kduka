# -*- encoding: utf-8 -*-
# stub: tabs_on_rails 3.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tabs_on_rails".freeze
  s.version = "3.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Simone Carletti".freeze]
  s.date = "2017-02-03"
  s.description = "TabsOnRails is a simple Ruby on Rails plugin for creating tabs and navigation menu for a Rails project.".freeze
  s.email = ["weppos@weppos.net".freeze]
  s.homepage = "https://simonecarletti.com/code/tabs-on-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A simple Ruby on Rails plugin for creating tabs and navigation menu".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, [">= 4.2"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, [">= 4.2"])
      s.add_dependency(%q<mocha>.freeze, [">= 1.0"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.2"])
    s.add_dependency(%q<mocha>.freeze, [">= 1.0"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
  end
end
