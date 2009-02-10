require "rubygems"

SPEC = Gem::Specification.new do |s|
  s.name                = "longurl"
  s.version             = "0.1"
  s.summary             = %q{LongURL expands shorten urls}
  s.description         = %q{LongURL expands short urls (tinyurl, ...) to original ones, using on LongURL.org, internal resolution or direct resolution}

  s.author              = "Fabien Jakimowicz"
  s.email               = "fabien@jakimowicz.com"
  s.homepage            = "http://longurl.rubyforge.org"
  s.rubyforge_project   = "longurl"

  s.platform            = Gem::Platform::RUBY
  s.files               = %w( README ) + Dir["{bin,lib,test,examples}/**/*"]
  s.require_path        = "lib"
  s.test_files          = ['test/test_service.rb']
  s.autorequire         = 'longurl'
  s.default_executable  = "longurl"
  s.executables         = ["longurl"]
  s.has_rdoc            = true
  s.extra_rdoc_files    = ["README", "TODO", "LICENSE", "ChangeLog"]
  s.rdoc_options        = [
                            "--title", "LongURL Documentation",
                            "--main", "README",
                            "-S",
                            "-N",
                            "--all"
                          ]

  s.add_dependency "json"
end