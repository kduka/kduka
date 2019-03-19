# -*- encoding: utf-8 -*-
# stub: errbase 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "errbase".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrew Kane".freeze]
  s.date = "2018-09-19"
  s.description = "Common exception reporting for a variety of services".freeze
  s.email = ["andrew@chartkick.com".freeze]
  s.homepage = "https://github.com/ankane/errbase".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Common exception reporting for a variety of services".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 5"])
      s.add_development_dependency(%q<rollbar>.freeze, [">= 0"])
      s.add_development_dependency(%q<airbrake>.freeze, [">= 0"])
      s.add_development_dependency(%q<honeybadger>.freeze, [">= 0"])
      s.add_development_dependency(%q<exceptional>.freeze, [">= 0"])
      s.add_development_dependency(%q<raygun4ruby>.freeze, [">= 0"])
      s.add_development_dependency(%q<sentry-raven>.freeze, [">= 0"])
      s.add_development_dependency(%q<bugsnag>.freeze, [">= 0"])
      s.add_development_dependency(%q<appsignal>.freeze, [">= 0"])
      s.add_development_dependency(%q<opbeat>.freeze, [">= 0"])
      s.add_development_dependency(%q<exception_notification>.freeze, [">= 0"])
      s.add_development_dependency(%q<google-cloud-error_reporting>.freeze, [">= 0"])
      s.add_development_dependency(%q<newrelic_rpm>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, [">= 5"])
      s.add_dependency(%q<rollbar>.freeze, [">= 0"])
      s.add_dependency(%q<airbrake>.freeze, [">= 0"])
      s.add_dependency(%q<honeybadger>.freeze, [">= 0"])
      s.add_dependency(%q<exceptional>.freeze, [">= 0"])
      s.add_dependency(%q<raygun4ruby>.freeze, [">= 0"])
      s.add_dependency(%q<sentry-raven>.freeze, [">= 0"])
      s.add_dependency(%q<bugsnag>.freeze, [">= 0"])
      s.add_dependency(%q<appsignal>.freeze, [">= 0"])
      s.add_dependency(%q<opbeat>.freeze, [">= 0"])
      s.add_dependency(%q<exception_notification>.freeze, [">= 0"])
      s.add_dependency(%q<google-cloud-error_reporting>.freeze, [">= 0"])
      s.add_dependency(%q<newrelic_rpm>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, [">= 5"])
    s.add_dependency(%q<rollbar>.freeze, [">= 0"])
    s.add_dependency(%q<airbrake>.freeze, [">= 0"])
    s.add_dependency(%q<honeybadger>.freeze, [">= 0"])
    s.add_dependency(%q<exceptional>.freeze, [">= 0"])
    s.add_dependency(%q<raygun4ruby>.freeze, [">= 0"])
    s.add_dependency(%q<sentry-raven>.freeze, [">= 0"])
    s.add_dependency(%q<bugsnag>.freeze, [">= 0"])
    s.add_dependency(%q<appsignal>.freeze, [">= 0"])
    s.add_dependency(%q<opbeat>.freeze, [">= 0"])
    s.add_dependency(%q<exception_notification>.freeze, [">= 0"])
    s.add_dependency(%q<google-cloud-error_reporting>.freeze, [">= 0"])
    s.add_dependency(%q<newrelic_rpm>.freeze, [">= 0"])
  end
end
