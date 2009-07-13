# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nullify_blanks}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew White"]
  s.date = %q{2009-07-13}
  s.description = %q{A simple wrapper class that provides basic access to the Prowl API.}
  s.email = %q{andyw@pixeltrix.co.uk}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "MIT-LICENSE",
     "README",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/nullify_blanks.rb",
     "tasks/nullify_blanks_tasks.rake",
     "test/fixtures/products.yml",
     "test/nullify_blanks_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pixeltrix/prowler/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Provides access to the Prowl API.}
  s.test_files = [
    "test/nullify_blanks_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
