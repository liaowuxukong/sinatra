$LOAD_PATH.unshift(File.dirname(__FILE__))
require "rubygems"
require "sinatra"
require "lib/apibus"



post '/' do 
  # 传来的内容就是params，如果除了name,action,resource,id之外，还有params，就是剩下的真正的params
  # params = {name_19900101:"dbooking",action_19900101:"index",
  #        resource_19900101:"rooms",id_19900101:"",
  #        people_email:"xuxin@cstnet.cn"}
  name = params.delete("name_19900101")
  action = params.delete("action_19900101")
  resource = params.delete("resource_19900101")
  id = params.delete("id_19900101")

  apibus = APIBus.new
  apibus.get_service(name,action,resource,id,params)

end

get '/' do 
  "nothing"
end




