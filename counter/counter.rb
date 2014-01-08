$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"
require "sinatra"

@counters = {}

get '/' do 
  "index"
end

# index
get '/counters' do
  "index"
end

# show
get '/counters/:id' do
  @id = params[:id]
  "show" + @id.to_s
end

#create
post '/counters/new' do
  "create"
end

# edit
get '/counters/:id/edit' do
  @id = params[:id]
  "edit" + @id.to_s
end
 
# update / delete
post '/counters/:id' do
  @id = params[:id]
  @method = params[:method]
  if @method == "put"
    "update" + @id.to_s
  elsif @method == "delete"
    "delete" + @id.to_s
  end
    
end



