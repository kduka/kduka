# -*- encoding: utf-8 -*-
# stub: file_validators 2.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "file_validators".freeze
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ahmad Musaffa".freeze]
  s.date = "2018-05-12"
  s.description = "Adds file validators to ActiveModel".freeze
  s.email = ["musaffa_csemm@yahoo.com".freeze]
  s.homepage = "https://github.com/musaffa/file_validators".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "ActiveModel file validators".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 3.2"])
      s.add_runtime_dependency(%q<mime-types>.freeze, [">= 1.0"])
      s.add_development_dependency(%q<cocaine>.freeze, ["~> 0.5.4"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activemodel>.freeze, [">= 3.2"])
      s.add_dependency(%q<mime-types>.freeze, [">= 1.0"])
      s.add_dependency(%q<cocaine>.freeze, ["~> 0.5.4"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activemodel>.freeze, [">= 3.2"])
    s.add_dependency(%q<mime-types>.freeze, [">= 1.0"])
    s.add_dependency(%q<cocaine>.freeze, ["~> 0.5.4"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
  end
end
