# -*- encoding: utf-8 -*-
# stub: referer-parser 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "referer-parser".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yali Sassoon".freeze, "Martin Loy".freeze, "Alex Dean".freeze, "Kelley Reynolds".freeze]
  s.date = "2014-09-03"
  s.description = "Library for extracting marketing attribution data from referer URLs".freeze
  s.email = ["support@snowplowanalytics.com".freeze]
  s.homepage = "http://github.com/snowplow/referer-parser".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Library for extracting marketing attribution data (e.g. search terms) from referer (sic) URLs. This is used by Snowplow (http://github.com/snowplow/snowplow). Our hope is that this library (and referers.yml) will be extended by anyone interested in parsing referer URLs.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.6"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0.9.2"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 2.6"])
      s.add_dependency(%q<rake>.freeze, [">= 0.9.2"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 2.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0.9.2"])
  end
end
