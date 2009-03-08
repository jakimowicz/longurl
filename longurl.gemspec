# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{longurl}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fabien Jakimowicz"]
  s.date = %q{2009-03-08}
  s.default_executable = %q{longurl}
  s.description = %q{LongURL expands short urls (tinyurl, is.gd, ...) to original ones, using on LongURL.org, internal resolution or direct resolution}
  s.email = %q{fabien@jakimowicz.com}
  s.executables = ["longurl"]
  s.files = ["VERSION.yml", "bin/longurl", "lib/longurl", "lib/longurl/constants.rb", "lib/longurl/direct.rb", "lib/longurl/exceptions.rb", "lib/longurl/expand.rb", "lib/longurl/expander.rb", "lib/longurl/service.rb", "lib/longurl/url.rb", "lib/longurl.rb", "test/cache_mock.rb", "test/constants.rb", "test/service", "test/service/no_cache_service_test.rb", "test/service/service_cache_test.rb", "test/service/service_test.rb", "test/service/supported_services_test.rb", "test/url_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://longurl.rubyforge.org}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{longurl}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{LongURL expands shorten urls (tinyurl, is.gd, ...)}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
  end
end
