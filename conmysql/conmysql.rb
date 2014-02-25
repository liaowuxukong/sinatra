$LOAD_PATH.unshift(File.dirname(__FILE__))

require "rubygems"
require "sinatra"
require 'mysql2'

before do
  client = Mysql2::Client.new(
    host: "10.10.1.159",
    username: 'root',
    password: '',
    database: 'test_mysql_development',
    port: 3306
  )
  @results = client.query("SELECT * FROM people")

end



get '/' do 
  return_value = ""
  @results.each do |row|
    row.each do |key, value|
      return_value += "#{key} : #{value} <br/>"
    end
  return_value += "<br/>"
  end
  return_value
end


