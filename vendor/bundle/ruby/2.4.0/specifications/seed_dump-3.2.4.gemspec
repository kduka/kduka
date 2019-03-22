# -*- encoding: utf-8 -*-
# stub: seed_dump 3.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "seed_dump".freeze
  s.version = "3.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rob Halff".freeze, "Ryan Oblak".freeze]
  s.date = "2015-12-25"
  s.description = "Dump (parts) of your database to db/seeds.rb to get a headstart creating a meaningful seeds.rb file".freeze
  s.email = "rroblak@gmail.com".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/rroblak/seed_dump".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "{Seed Dumper for Rails}".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4"])
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 4"])
      s.add_development_dependency(%q<byebug>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<factory_girl>.freeze, ["~> 4.0"])
      s.add_development_dependency(%q<activerecord-import>.freeze, ["~> 0.4"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 4"])
      s.add_dependency(%q<activerecord>.freeze, [">= 4"])
      s.add_dependency(%q<byebug>.freeze, ["~> 2.0"])
      s.add_dependency(%q<factory_girl>.freeze, ["~> 4.0"])
      s.add_dependency(%q<activerecord-import>.freeze, ["~> 0.4"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4"])
    s.add_dependency(%q<activerecord>.freeze, [">= 4"])
    s.add_dependency(%q<byebug>.freeze, ["~> 2.0"])
    s.add_dependency(%q<factory_girl>.freeze, ["~> 4.0"])
    s.add_dependency(%q<activerecord-import>.freeze, ["~> 0.4"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0"])
  end
end
