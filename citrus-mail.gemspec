# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

require 'citrus_mail/version'

Gem::Specification.new do |s|
  s.name = "citrus-mail"
  s.version = CitrusMail::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Piotr Boniecki", "GaldoMedia"]
  s.date = %q{2011-05-17}
  s.description = %q{Gem that gives you easy integration with polish mailing service FreshMail (freshmail.pl)}
  s.summary = %q{Nifty Rails gem for nice FreshMail integration}
  s.email = %q{piotr@galdomedia.pl}
  s.homepage = "https://github.com/galdomedia/citrus-mail"
  s.licenses = ["MIT"]

  #s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  #s.test_files = Dir["test/**/*"]
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.require_paths = ["lib"]
end
