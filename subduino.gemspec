# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'subduino/version'

Gem::Specification.new do |s|
  s.name = %q{subduino}
  s.version = Subduino::VERSION

  s.authors = ["Marcos Piccinini"]
  s.description = %q{Interface, compile, upload... Play with arduino on ruby!}
  s.summary = %q{Arduino Ruby Helpers}
  s.email = %q{x@nofxx.com}
  s.executables = ["subduino", "subduino-cli"]
  s.extensions = ["ext/subduino/extconf.rb"]

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.md Rakefile)

  s.homepage = %q{http://github.com/nofxx/subduino}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}

  s.add_runtime_dependency(%q<redis>, [">= 0"])
  s.add_runtime_dependency(%q<serialport>, [">= 0"])
  s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
  s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
end

