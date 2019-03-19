# -*- encoding: utf-8 -*-
# stub: nprogress-rails 0.2.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "nprogress-rails".freeze
  s.version = "0.2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Carlos Alexandro Becker".freeze]
  s.date = "2016-08-05"
  s.description = "This is a gem for the rstacruz' nprogress implementation. It's based on version nprogress 0.2.0.".freeze
  s.email = ["caarlos0@gmail.com".freeze]
  s.homepage = "https://github.com/caarlos0/nprogress-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Slim progress bars for Ajax'y applications. Inspired by Google, YouTube, and Medium.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<sass-rails>.freeze, [">= 0"])
      s.add_development_dependency(%q<sass>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<sass-rails>.freeze, [">= 0"])
      s.add_dependency(%q<sass>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<sass-rails>.freeze, [">= 0"])
    s.add_dependency(%q<sass>.freeze, [">= 0"])
  end
end
