$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"
require "sinatra"
require 'mysql2'
require "model/people"
require "model/room"
require "model/time_quota"

# index
get '/:resource' do 
  resource = params[:resource]
  if resource == "rooms_time"
    rooms_index(params)
  else
    "resource error"
  end
  
end

# create
post '/:resource' do
  resource = params[:resource]
  if resource == "rooms_time"
    rooms_time_create(params)
  else
    "resource error"
  end 
end


# update / delete
post '/:resource/:id' do
  method    = params[:method]
  resource  = params[:resource]
  if method == "put"
    update(params)
  elsif method == "delete"
    if resource == "rooms_time"
      rooms_time_delete(params)
    else
      "resource error"
    end
  else
    @return_value[:status] = "fail"
    @return_value[:info] = "params error"
    @return_value.to_json
  end
    
end



# http://127.0.0.1:4567/rooms?people_email=xuxin@cstnet.cn&start_time=2014_02_25_16_00&end_time=2014_02_25_18_00
def rooms_index(params)
  start_time    = params[:start_time]
  end_time      = params[:end_time]
  people_email  = params[:people_email]

  result,people = People.find_by_email(people_email)
  return people.to_s unless result

  if start_time==nil and end_time == nil
    result,rooms_list = people.find_all_rooms
  else
    start_time  = transform_time(start_time)
    end_time    = transform_time(end_time)
    rooms_list  = people.find_unbooking_room(start_time,end_time)
  end
  result = ""

  rooms_list.each do |room|
    number = room.number
    description = room.description
    result += "#{number}_"
  end
  result.chop
end

def rooms_time_create(params)
  people_email  = params[:people_email]
  room_number   = params[:room_number]
  start_time    = params[:start_time]
  end_time      = params[:end_time]

  result,people = People.find_by_email(people_email)
  return people.to_s unless result

  start_time  = transform_time(start_time)
  end_time    = transform_time(end_time)

  result,msg = people.booking(room_number,start_time,end_time)
  msg
end

def rooms_time_delete(params)
  people_email  = params[:people_email]
  room_number   = params[:room_number]
  start_time    = params[:start_time]
  end_time      = params[:end_time]

  result,people = People.find_by_email(people_email)
  return people.to_s unless result

  start_time  = transform_time(start_time)
  end_time    = transform_time(end_time)

  result,msg = people.cancel_booking(room_number,start_time,end_time)
  msg

end


def transform_time(time_str)
  time_list = time_str.split('_')
  Time.mktime(time_list[0],time_list[1],time_list[2],time_list[3],time_list[4])
end