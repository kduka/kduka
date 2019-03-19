# -*- encoding: utf-8 -*-
# stub: image_optimizer 1.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "image_optimizer".freeze
  s.version = "1.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Julian Tescher".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDdDCCAlygAwIBAgIBATANBgkqhkiG9w0BAQUFADBAMRIwEAYDVQQDDAlqYXRl\nc2NoZXIxFTATBgoJkiaJk/IsZAEZFgVnbWFpbDETMBEGCgmSJomT8ixkARkWA2Nv\nbTAeFw0xNjA5MjYxNzU4NTRaFw0xNzA5MjYxNzU4NTRaMEAxEjAQBgNVBAMMCWph\ndGVzY2hlcjEVMBMGCgmSJomT8ixkARkWBWdtYWlsMRMwEQYKCZImiZPyLGQBGRYD\nY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7ptCQvN739Rjos4e\nG2Y8uGCQxpBoXozU36PXLtR5ws7aly1QV0zRc1cy7nKnOSnXn7dEfbLGZS6/87pM\nrDFFszHsn/dizlXe3wejHePyG1EsYnIezISP9YSDcm7qpysrUAa2fKPqqZ6DNbIP\n6wRF9Cun4hvmQPDrs0zKU6p43XHnJUg7YBYCOVACa7eFD1EOya+599hFMhnWChvT\nrKkVc/JRvmKYLIkB6Y6N3TFrVi9x0Qpo4fjG5rQ9xxNZhpFIOMJ0VJbuRSIMlLwr\nRyd/QG0BcvkSHph/ZDlgfZ1V/lzWWq+mZOt/U+t6cVITSET5XDzHkeZ0BodGyAMr\nlZpggQIDAQABo3kwdzAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHQ4EFgQU\nQLcGxzEu2F2XI+3tIWSu8KqAFrkwHgYDVR0RBBcwFYETamF0ZXNjaGVyQGdtYWls\nLmNvbTAeBgNVHRIEFzAVgRNqYXRlc2NoZXJAZ21haWwuY29tMA0GCSqGSIb3DQEB\nBQUAA4IBAQCh9hDqN3lZw0PLVkXVcnwnl3KAjJfwCwk1okeuJ+IeQSfRLPp2ECLn\nj87oXZPcBukPB0/zTHcF/eBPIGvOedqVhp9SEar51dXLdiCe+deXx/bI3YMRdTGH\n6NtqR6hWjm+hzBthxDsKhmQRczJ+5FNzAoW+pzf7ouKGfeFiFPwvAMolzsi2T+O/\nAmsZcBYVI8HbrnuoQI30XfdhNoRrKhoMyzAyVdWX9xQW56TWUO+o8iXBKjOxX2C5\n8lVFrLvGNGPCLQmEf498hBYT99EVYiuiI0F7YlTmBdzL1uwTMk5le/b0NguYdSJ7\nqKlUP9usSwMVc+qmaOg1EYfPGYvt63qS\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2016-11-15"
  s.description = "A simple image optimizer".freeze
  s.email = ["jatescher@gmail.com".freeze]
  s.homepage = "https://github.com/jtescher/image_optimizer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Simply optimize images via jpegoptim or OptiPNG or Gifsicle".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<mime-types>.freeze, ["~> 1.25.1"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<mime-types>.freeze, ["~> 1.25.1"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<mime-types>.freeze, ["~> 1.25.1"])
  end
end
