require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "subduino"
    gem.summary = "Arduino Ruby Helpers"
    gem.description = "Interface, compile, upload, play with arduino/ruby"
    gem.email = "x@nofxx.com"
    gem.homepage = "http://github.com/nofxx/subduino"
    gem.authors = ["Marcos Piccinini"]
    gem.add_dependency "redis"
    gem.add_dependency "eventmachine"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end

# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end

# task :spec => :check_dependencies

# task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "subduino #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

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
