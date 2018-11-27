require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

$:.unshift File.expand_path('../../', __FILE__)

require "rubygems"
require "rspec"
require "rr"
require "database_cleaner"
require "vidibus-textile"

Mongoid.configure do |config|
  config.connect_to('vidibus-textile')
end
Mongo::Logger.logger.level = Logger::INFO
RSpec.configure do |config|
  config.mock_with :rr
  # config.before(:each) do
  #   Mongoid::Sessions.default.collections.
  #     select {|c| c.name !~ /system/}.each(&:drop)
  # end
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
