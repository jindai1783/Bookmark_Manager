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

get '/links/new' do
  erb :"links/new"
end