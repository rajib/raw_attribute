require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
gem 'sqlite3-ruby'
require 'active_record'
require 'action_controller'
require 'action_view'
require 'test/unit'

ENV['RAILS_ENV'] ||= 'test'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(config['test'])

load(File.dirname(__FILE__) + "/schema.rb")

require File.dirname(__FILE__) + '/../init.rb'

