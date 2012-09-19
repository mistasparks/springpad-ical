require "bundler/setup"
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.db")

get '/' do
  erb :index
end

get '/:id' do
  
end
