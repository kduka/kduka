# -*- encoding: utf-8 -*-
# stub: bootstrap-colorpicker-rails 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-colorpicker-rails".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Matteo Alessani".freeze]
  s.date = "2014-08-21"
  s.description = "A color picker for Twitter Bootstrap".freeze
  s.email = ["alessani@gmail.com".freeze]
  s.homepage = "https://github.com/alessani/bootstrap-colorpicker-rails".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A color picker for Twitter Bootstrap".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 4.0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 4.0"])
      s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 4.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
