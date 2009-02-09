require "rake"
require "rake/rdoctask"
require "rake/testtask"

task :default => [ :test, :doc ]

desc "Run the tests"
Rake::TestTask.new("test") { |t|
  t.pattern = "test/**/ts_*.rb"
  t.verbose = true
}

desc "Write the documentation"
Rake::RDocTask.new("doc") { |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title = "LongURL Documentation"
  rdoc.rdoc_files.include("README")
  rdoc.rdoc_files.include("TODO")
  rdoc.rdoc_files.include("LICENSE")
  rdoc.rdoc_files.include("ChangeLog")
  rdoc.rdoc_files.include("lib/*.rb")
  rdoc.rdoc_files.include("lib/**/*.rb")
  rdoc.rdoc_files.exclude("test/*")
}

desc "Statistics for the code"
task :stats do
  begin
    require "code_statistics"
    CodeStatistics.new(["Code", "lib"],
                       ["Units", "test"]).to_s
  rescue LoadError
    puts "Couldn't load code_statistics (install rails)"
  end
end