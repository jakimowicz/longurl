require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name              = "longurl"
    s.summary           = %q{LongURL expands shorten urls (tinyurl, is.gd, ...)}
    s.homepage          = "http://longurl.rubyforge.org"
    s.description       = %q{LongURL expands short urls (tinyurl, is.gd, ...) to original ones, using on LongURL.org, internal resolution or direct resolution}
    s.authors           = ["Fabien Jakimowicz"]
    s.email             = "fabien@jakimowicz.com"
    s.rubyforge_project = 'longurl'

    s.add_dependency 'json'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc "build rdoc using hanna theme"
task :rdoc do
  `rm -rf rdoc && rdoc -o rdoc --inline-source --format=html -T hanna README* lib/**/*.rb`
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  puts "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
end

# Rubyforge publishing
begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]

    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/gforge-projects/longurl/"
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end

task :default => :test