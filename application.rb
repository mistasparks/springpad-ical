require "bundler/setup"
require 'sinatra'
require 'data_mapper'
require 'dm-types'
require 'uuidtools'
require 'net/http'
require 'uri'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.db")

class Link
  include DataMapper::Resource

  property :id, UUID, :key => true, :default => lambda { |r, p| UUIDTools::UUID.random_create }
  property :url, String, :length => 250
end

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
  @link = Link.create(:url => "")
  erb :index
end

post '/' do
  content_type :json

  link = Link.create(:url => params[:url])

  return { :success => true, :id => link.id }
end

get '/:id' do
  url = URI.parse(Link.get(params[:id]).url)
  Net::HTTP.get_response(url).body  
end
