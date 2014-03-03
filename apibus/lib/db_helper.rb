require "mysql2"

module DBHelp
  def get_client
    client = Mysql2::Client.new(
      host: "10.10.1.159",
      username: 'root',
      password: '',
      database: 'appeng',
      port: 3306
    )
    client
  end

  
  def exec_select(sql_query,success_message="")
    begin
      result = get_client.query(sql_query)
      [result,success_message]
    rescue Mysql2::Error=>e
      [false,e]
    end
  end

  def exec_proc(sql_query,success_message="")
    begin
      get_client.query(sql_query)
      [true,success_message]
    rescue Mysql2::Error=>e
      [false,e]
    end      
  end

end