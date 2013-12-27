$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"
require "sinatra"
require "api_bus"

get '/' do 
    api = APIBus.new
    result = api.get_service(:get_time)
    result
end
