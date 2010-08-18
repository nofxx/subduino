require 'rubygems'
require 'god'
require 'sinatra'
require 'stringio'
require 'yaml'
require 'erb'
require 'optparse'
require File.dirname(__FILE__) + '/duino'

config = {
  'username' =>  nil,
  'password' =>  nil
}

begin
  config.merge!(YAML.load(File.read(ARGV[0])))
  DUINO_CONFIG = config
rescue
  DUINO_CONFIG = config
end
DUINO = Duino.new(config)

# Require app
require File.dirname(__FILE__) + '/app'

Sinatra::Application.public = File.dirname(__FILE__) + "/../public"
Sinatra::Application.views = File.dirname(__FILE__) + "/../views"
