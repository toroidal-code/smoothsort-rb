# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smoothsort/version'

Gem::Specification.new do |spec|
  spec.name          = "smoothsort"
  spec.version       = Smoothsort::VERSION
  spec.authors       = ["Katherine Whitlock"]
  spec.email         = ["toroidalcode@gmail.com"]
  spec.description = "This is an implementation of Djikstra's smoothsort sorting algorithm, usable on Enumerable objects"
  spec.summary       = "The smoothsort algorithm as a gem"
  spec.homepage      = "http://github.com/toroidal-code/smoothsort-rb"
  spec.license       = "MIT"

  
  spec.files = Dir.glob('lib/**/*.rb') +
               Dir.glob('ext/**/*.{c,h,rb}')
  spec.extensions = ['ext/smoothsort/extconf.rb']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'minitest', ">= 0"
  spec.add_development_dependency 'minitest-reporters', ">= 0.5.0"
end
