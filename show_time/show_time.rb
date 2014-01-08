
require "sinatra"

get '/times' do 
  "#{Time.now}"
end

get '/' do
  "#{Time.now}"
end

