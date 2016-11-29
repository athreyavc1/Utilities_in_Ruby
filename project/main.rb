require 'sinatra'

get '/hello' do 
 name = "Andy"
 "Hello #{name}"
end
