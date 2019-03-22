# -*- encoding: utf-8 -*-
# stub: froala-editor-sdk 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "froala-editor-sdk".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Froala Labs".freeze]
  s.date = "2017-08-14"
  s.description = "Ruby SDK for Froala Editor".freeze
  s.homepage = "https://github.com/froala/wysiwyg-editor-ruby-sdk".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Ruby on Rails SDK for Froala WYSIWYG Editor.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>.freeze, ["~> 3.1"])
      s.add_runtime_dependency(%q<wysiwyg-rails>.freeze, ["~> 2.6.0"])
      s.add_runtime_dependency(%q<mini_magick>.freeze, ["~> 4.5.0"])
    else
      s.add_dependency(%q<mime-types>.freeze, ["~> 3.1"])
      s.add_dependency(%q<wysiwyg-rails>.freeze, ["~> 2.6.0"])
      s.add_dependency(%q<mini_magick>.freeze, ["~> 4.5.0"])
    end
  else
    s.add_dependency(%q<mime-types>.freeze, ["~> 3.1"])
    s.add_dependency(%q<wysiwyg-rails>.freeze, ["~> 2.6.0"])
    s.add_dependency(%q<mini_magick>.freeze, ["~> 4.5.0"])
  end
end
