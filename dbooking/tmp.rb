$LOAD_PATH.unshift(File.dirname(__FILE__))
require "model/people"
require "dao/people_room_time_dao"



result,people = People.find_by_email("xuxin@cstnet.cn")
unless result
  puts people
  return
end


start_time = Time.mktime(2014,2,25,16,00)
end_time = Time.mktime(2014,2,25,15)

=begin

unbooking_rooms = people.find_unbooking_room(start_time,end_time)
puts unbooking_rooms.inspect


result,msg = people.cancel_booking("102",start_time,end_time)
puts msg



result,msg = people.booking("101",start_time,end_time)
puts msg;

=end
