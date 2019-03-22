# -*- encoding: utf-8 -*-
# stub: device_detector 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "device_detector".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mati S\u00F3jka".freeze, "Ben Zimmer".freeze]
  s.date = "2018-04-27"
  s.description = "Precise and fast user agent parser and device detector, backed by the largest and most up-to-date agent and device database".freeze
  s.email = ["yagooar@gmail.com".freeze]
  s.homepage = "http://podigee.github.io/device_detector".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Precise and fast user agent parser and device detector".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0.10"])
    else
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0.10"])
    end
  else
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0.10"])
  end
end
