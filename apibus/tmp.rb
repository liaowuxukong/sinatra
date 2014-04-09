require "net/http"


=begin
uri = "http://127.0.0.1:4567"
params = {
          name_19900101:"dbooking",
          action_19900101:"index",
          resource_19900101:"rooms_time",
          people_email:"liwei@cstnet.cn",
          id_19900101:""}
uri = URI.parse(uri)
resp = Net::HTTP.post_form(uri,params)

puts resp.body
=end

