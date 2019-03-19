# -*- encoding: utf-8 -*-
# stub: user_agent_parser 2.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "user_agent_parser".freeze
  s.version = "2.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tim Lucas".freeze]
  s.date = "2017-10-02"
  s.description = "A simple, comprehensive Ruby gem for parsing user agent strings with the help of BrowserScope's UA database".freeze
  s.email = "t@toolmantim.com".freeze
  s.executables = ["user_agent_parser".freeze]
  s.files = ["bin/user_agent_parser".freeze]
  s.homepage = "https://github.com/ua-parser/uap-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A simple, comprehensive Ruby gem for parsing user agent strings with the help of BrowserScope's UA database".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<coveralls>.freeze, ["= 0.8.21"])
    else
      s.add_dependency(%q<coveralls>.freeze, ["= 0.8.21"])
    end
  else
    s.add_dependency(%q<coveralls>.freeze, ["= 0.8.21"])
  end
end
