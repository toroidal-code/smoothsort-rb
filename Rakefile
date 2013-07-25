require "bundler/gem_tasks"



require 'rake/testtask'
require 'rake/clean'

NAME = 'smoothsort'

# rule to build the extension: this says
# that the extension should be rebuilt
# after any change to the files in ext
file "lib/#{NAME}/#{NAME}.so" => Dir.glob("ext/#{NAME}/*{.rb,.c}") do
  Dir.chdir("ext/#{NAME}") do
    # this does essentially the same thing
    # as what RubyGems does
    ruby "extconf.rb"
    sh "make"
  end
  cp "ext/#{NAME}/#{NAME}.so", "lib/#{NAME}"
end

# make the :test task depend on the shared
# object, so it will be built automatically
# before running the tests
task :test => "lib/#{NAME}/#{NAME}.so"

# use 'rake clean' and 'rake clobber' to
# easily delete generated files
CLEAN.include('ext/**/*{.o,.log,.so}')
CLEAN.include('ext/**/Makefile')
CLOBBER.include('lib/**/*.so')

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
