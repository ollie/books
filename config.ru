require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

require File.expand_path( File.join('..', 'app', 'app'), __FILE__ )

use Rack::Static, urls: [ '/stylesheets', '/javascripts', '/images' ], root: 'public'

run App.new
