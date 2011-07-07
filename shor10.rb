require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class URL
  include DataMapper::Resource  
  property :id,           Serial
  property :url,          String
end

DataMapper.auto_upgrade!

# Display form to enter URL to be shortened 
get '/' do
  erb :new
end 


# Display original URL
get '/:id' do
  @url = URL.get(params[:id])
  erb :url
end
