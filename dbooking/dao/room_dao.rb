root_path = File.join(File.dirname(__FILE__), "..")
$LOAD_PATH.unshift(root_path) unless $LOAD_PATH.include?(root_path) 

require "help/db_help"
require "model/room"

module DBOOKING::RoomDAO

  include DBOOKING::DBHelp

  def insert(room)
    sql_query = "insert into rooms (number,description) values "+
                "(\"#{room.number}\",\"#{rooms.description}\");"
    exec_proc(sql_query,"insert success")
  end

  def delete(room)
    sql_query = "delete from rooms where number=\"#{room.number}\";"
    exec_proc(sql_query,"delete success");    
  end

  def update(new_room,old_room)
    result,msg = find_by_number(old_room.number)
    return [false,msg] unless result
    sql_query = "update rooms set number=\"#{new_room.email}\","+
                "description=\"#{new_room.description}\""+
                "where number=\"#{old_room.number}\";"
    exec_proc(sql_query,"update success")    
  end

  def find_by_number(number)
    sql_query = "select * from rooms where number = \"#{number}\";"
    result,msg = exec_select(sql_query,"select success")
    return [false,msg] unless result
    return [false,"not found room #{number}"] if result.count == 0
    number = description = ""
    result.each do |row|
      number =  row["number"]
      description = row["description"]
    end
    [true,Room.new(number,description)]
  end

end
