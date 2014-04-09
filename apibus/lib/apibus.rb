root_path = File.join(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift(root_path) unless $LOAD_PATH.include?(root_path)

require "net/http"
require 'yaml' 
require 'lib/db_helper'

class APIBus
  include DBHelp
  # 从文件中读取，建立hash表
  def initialize
    #yaml_file = File.expand_path(File.join(File.dirname(__FILE__), "service_map.yaml"))
    #@service_uris = YAML::load(File.open(yaml_file))
  end

  def get_service(name,action,resource,id=0,params={})
    sql_query = "select * from name_url where name=\"#{name}\";"
    result,msg = exec_select(sql_query,"select success")
    url = ""
    result.each do |row|
      url = row["url"]
    end    
    domain = url.strip

    puts "domain = #{domain}"
    action = action.to_sym
    resource = resource.to_sym
    trans_method = 
      case action
      when :index,:show,:new,:edit
        :get
      else
        :post
      end
    #puts "trans_method = #{trans_method}"

    uri = domain + "/" + resource.to_s +
      case action
      when :show
        "/" + id.to_s        
      when :new
        "/" + "new"
      when :edit
        "/" + id.to_s + "/edit"
      when :update
        params[:method] = :put
        "/" + id.to_s        
      when :delete
        params[:method] = :delete
        "/" + id.to_s 
      else
        ""
      end

    if trans_method == :get && params.count != 0
    
      uri = uri + '?'
      params.each do |key,value|
        uri += key.to_s+"="+value.to_s+"&"
      end
      uri = uri.chop
    end
    puts "uri = #{uri}"

    uri = URI.parse(uri)
    resp = 
      case trans_method
      when :get
        Net::HTTP.get_response(uri)
      else
        Net::HTTP.post_form(uri,params)
      end
    resp.body

  end
end

=begin
apibus = APIBus.new
apibus.get_service(:dbooking,:index,:rooms,0,{start_time:"10:10",end_time:"11:30"})
=end
