root_path = File.join(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift(root_path) unless $LOAD_PATH.include?(root_path) 

require "help/db_help"
require "model/room"
require "model/time_quota"

module DBOOKING::PeopleRoomTimeDAO
  include DBOOKING::DBHelp

  def find_people_by_room_time(room_number,start_time,end_time)
    
  end

  def find_room_by_people_time(email,start_time,end_time)
    
  end

  def find_time_by_people_room(email,room_number)
    
  end

  def find_all_by_room(room_number)
    sql_query = "select * from rooms_time_people where room_number=\"#{room_number}\";"
    result,msg = exec_select(sql_query,"select success")
    return [false,msg] unless result
    return [false,"not found anything"] if result.count == 0
    booking_hash = {}

    result.each do |row|
      people_email = row["people_email"]
      time_quota_list = booking_hash[people_email] || Array.new
      time_quota_list << TimeQuota.new(row['start_time'],row['end_time'])
      booking_hash[people_email] = time_quota_list
    end
    [true,booking_hash]
  end

  def insert_people_room_time(people_email,room_number,start_time,end_time)
    sql_query = "insert into rooms_time_people "+
                "(room_number,people_email,start_time,end_time) values "+
                "(\"#{room_number}\",\"#{people_email}\","+
                "\"#{start_time}\",\"#{end_time}\");"
    exec_proc(sql_query,"insert success")
  end


end