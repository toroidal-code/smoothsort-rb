require "bundler/gem_tasks"


require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['test'].exec
end

task :default => :test
