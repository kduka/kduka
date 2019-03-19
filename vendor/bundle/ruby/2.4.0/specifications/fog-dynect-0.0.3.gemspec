# -*- encoding: utf-8 -*-
# stub: fog-dynect 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "fog-dynect".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Wesley Beary".freeze, "The fog team".freeze]
  s.date = "2016-03-17"
  s.description = "This library can be used as a module for `fog` or as\n                        standalone provider to use Dynect DNS in applications.".freeze
  s.email = ["geemus@gmail.com".freeze]
  s.homepage = "http://github.com/fog/fog-dynect".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Module for the 'fog' gem to support Dynect DNS.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<shindo>.freeze, ["~> 0.3"])
      s.add_runtime_dependency(%q<fog-core>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<fog-json>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<fog-xml>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<shindo>.freeze, ["~> 0.3"])
      s.add_dependency(%q<fog-core>.freeze, [">= 0"])
      s.add_dependency(%q<fog-json>.freeze, [">= 0"])
      s.add_dependency(%q<fog-xml>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<shindo>.freeze, ["~> 0.3"])
    s.add_dependency(%q<fog-core>.freeze, [">= 0"])
    s.add_dependency(%q<fog-json>.freeze, [">= 0"])
    s.add_dependency(%q<fog-xml>.freeze, [">= 0"])
  end
end
