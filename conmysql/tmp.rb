$LOAD_PATH.unshift(File.dirname(__FILE__))
require "db_help.rb"


client = Mysql2::Client.new(
  host: "10.10.1.159",
  username: 'root',
  password: '',
  database: 'test_mysql_development',
  port: 3306
)
results = client.query("SELECT * FROM people")
results.each do |row|
  row.each do |key, value|
    puts "#{key} : #{value}"
  end
  puts 
end