require 'sinatra/base'
require 'data_mapper'
require './lib/helpers/application'
require './lib/data_mapper_setup'
require 'rack-flash'

class Bookmark < Sinatra::Base

include Application

enable :sessions
use Rack::Flash
set :session_secret, 'super secret'

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do
    # puts '===' * 30
    # puts params.inspect
    # {"url"=>"www.makersacademy.com", "title"=>"Makers", "tags"=>"education ruby javascript"}
    url = params["url"]
    title = params["title"]
    tags = params["tags"].split(' ').map do |tag|
      Tag.first_or_create(:text => tag)
    end
    Link.create(:url => url, :title => title, :tags => tags)
    redirect to('/')
  end

  get '/tags/:text' do
    tag = Tag.first(:text => params[:text])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.new(:email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])

    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
