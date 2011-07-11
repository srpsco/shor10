require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'thin'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class URL
  include DataMapper::Resource  
  property :id,           Serial
  property :url,          Text
end

DataMapper.auto_upgrade!

# Display form to enter URL to be shortened 
get '/' do
  erb :new
end 


# Display original URL
get '/:id' do
  url = URL.get(params[:id])
  redirect url.url
end

# Shorten the URL
post '/url/shorten' do
  url = URL.new(:url => params[:url])
  if url.save
#    status 201
#    redirect '/'+url.id.to_s 
     @shorturl = url
     erb :shortened
   else
    status 412
    redirect '/'   
  end
end 
