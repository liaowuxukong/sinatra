$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"
require "sinatra"
require "lib/apibus"

get '/' do 
    api = APIBus.new
    result = api.get_service(:showtime,:index,:times)
    result
end
