require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'

require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'

include Helper
enable :sessions
use Rack::Flash
use Rack::MethodOverride
set :session_secret, 'super secret'
set :partial_template_engine, :erb