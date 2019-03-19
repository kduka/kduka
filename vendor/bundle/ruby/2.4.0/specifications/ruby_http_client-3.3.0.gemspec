# -*- encoding: utf-8 -*-
# stub: ruby_http_client 3.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby_http_client".freeze
  s.version = "3.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Elmer Thomas".freeze]
  s.date = "2017-10-30"
  s.description = "Quickly and easily access any REST or REST-like API.".freeze
  s.email = "dx@sendgrid.com".freeze
  s.homepage = "http://github.com/sendgrid/ruby-http-client".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A simple REST client".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 0"])
  end
end
