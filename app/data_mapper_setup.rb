require './app/models/link'
require './app/models/tag'
require './app/models/user'

# is ENV defined? If yes, use directly; if no, call development.
env = ENV['RACK_ENV'] || 'development'

# DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

DataMapper.finalize



