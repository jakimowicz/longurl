require "rubygems"

SPEC = Gem::Specification.new do |s|
  s.name = "longurl"
  s.version = "0.0.1"
  s.author = "Fabien Jakimowicz"
  s.email = "fabien@jakimowicz.com"
  s.homepage = "http://github.com/jakimowicz/longurl/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Expand short urls (tinyurl, ...) to original ones, using on LongURL.org, internal resolution or direct resolution"
  candidates = Dir["{bin,lib,doc,test,examples}/**/*"]
  s.files = candidates
  s.require_path = "lib"
  s.rubyforge_project = "longurl"
  # s.autorequire = "longurl"
  s.test_file = "test/ts_all.rb"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "TODO", "LICENSE", "ChangeLog"]
  s.rdoc_options = [
    "--title", "LongURL Documentation",
    "--main", "README",
    "-S",
    "-N",
    "--all"]
  s.default_executable = "longurl"
  s.executables = ["longurl"]
end