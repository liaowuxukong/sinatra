require "rubygems"
require "sinatra"
require "net/http"

get '/' do 
    uri = "http://showtime.dc.escience.cn/"
    resp = Net::HTTP.get_response(URI.parse(uri))
    resp.body
end
