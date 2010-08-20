#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))

require 'rubygems'
require 'sinatra'
require 'eventmachine'
require 'readline'
require 'redis'
require 'stringio'
require 'yaml'
require 'haml'
require 'optparse'
require 'duino'
require 'subduino/parse'

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
require "messenger"
include Messenger
require "app"

Sinatra::Application.public = File.dirname(__FILE__) + "/../public"
Sinatra::Application.views = File.dirname(__FILE__) + "/../views"
