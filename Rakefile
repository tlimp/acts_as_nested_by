require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_nested_by"
    gem.summary = %Q{Add a acts_as_nested_by :nesting_model class method to ActiveRecord::Base models}
    gem.description = %Q{
      The acts_as_nested_by class method add 3 instance methods to the model.
      nested_by_nesting_model=(flag) sets the nesting_model 
      nested_by_nesting_model returns true if nested_by nesting_model
      nested_by_nesting_model? alias for nested_by_nesting_model
      }
    gem.email = "thomas.limp@valiton.com"
    gem.homepage = "http://github.com/tehael/acts_as_nested_by"
    gem.authors = ["Thomas Limp"]
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_development_dependency "sqlite3-ruby", ">= 0"
    gem.add_dependency "activerecord"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "acts_as_nested_by #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
