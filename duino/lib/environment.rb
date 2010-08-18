#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__))) #, '..', 'lib'))
require 'rubygems'
require 'sinatra'
require 'stringio'
require 'yaml'
require 'haml'
require 'optparse'
require 'duino'

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
require "app"

Sinatra::Application.public = File.dirname(__FILE__) + "/../public"
Sinatra::Application.views = File.dirname(__FILE__) + "/../views"
