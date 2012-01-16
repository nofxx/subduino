require 'bundler'
Bundler.setup

require "rspec"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "subduino/version"

desc "Builds the gem"
task :gem => :build
task :build do
  system "gem build subduino.gemspec"
  Dir.mkdir("pkg") unless Dir.exists?("pkg")
  system "mv subduino-#{Subduino::VERSION}.gem pkg/"
end

task :install => :build do
  system "sudo gem install pkg/subduino-#{Subduino::VERSION}.gem"
end

task :release => :build do
  system "git tag -a v#{Subduino::VERSION} -m 'Tagging #{Subduino::VERSION}'"
  system "git push --tags"
  system "gem push pkg/subduino-#{Subduino::VERSION}.gem"
end


RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => [:spec]

desc "Download and install arduino libraries"
task :clibs do |t|
  puts "Starting...."
  get_c_lib("Messenger")
  puts "Done"
  #/usr/share/arduino/libraries

end


def get_c_lib(name)
  puts "C LIB #{name}"
  `mkdir #{name}`
  [:h, :cpp].each do |ext|
    next if File.exists?("#{name}/#{name}.#{ext}")
    `wget http://github.com/nofxx/Messenger/raw/master/arduino/Messenger/#{name}.#{ext} -O #{name}/#{name}.#{ext}`
  end
  install_c_lib(name)
end

def install_c_lib(name)
  try_root("mv ./#{name} /usr/share/arduino/libraries/#{name}")
end

def try_root(comm)
  unless system(comm)
    puts "Trying sudo..."
    `sudo #{comm}`
  end
end
