# -*- encoding: utf-8 -*-
# stub: wysiwyg-rails 2.6.6 ruby lib

Gem::Specification.new do |s|
  s.name = "wysiwyg-rails".freeze
  s.version = "2.6.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Froala Labs".freeze]
  s.date = "2017-09-13"
  s.description = "A beautiful jQuery WYSIWYG HTML text editor. High performance and modern design make it easy to use for developers and loved by users.".freeze
  s.email = ["stefan@froala.com".freeze]
  s.homepage = "https://github.com/froala/wysiwyg-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "an asset gemification of the Froala WYSIWYG Editor library".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, ["< 6.0", ">= 3.2"])
      s.add_runtime_dependency(%q<font-awesome-sass>.freeze, [">= 4.4.0", "~> 4.4"])
    else
      s.add_dependency(%q<railties>.freeze, ["< 6.0", ">= 3.2"])
      s.add_dependency(%q<font-awesome-sass>.freeze, [">= 4.4.0", "~> 4.4"])
    end
  else
    s.add_dependency(%q<railties>.freeze, ["< 6.0", ">= 3.2"])
    s.add_dependency(%q<font-awesome-sass>.freeze, [">= 4.4.0", "~> 4.4"])
  end
end
