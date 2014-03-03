class ChatLog < Log
  attr :agg_items
  attr :unit_time
  $chat_events = {"enter-room" => "person(s) entered room", "leave-room"=> "person(s) left the room", "comment"=>"comment(s)", "high-five"=>"high five(s) between users"}
  $units_time = {"minute"=> 60, "hour"=> 60*60, "day" => 60*60*24}

  def initialize(*args)
    if (args.length > 0)
      super *args
    else
      self.seed_data
    end
  end

  def seed_data
    #try from db
    #try from file

    #set statically
    $time1 = "1393709493"
    $data1 = {"username"=> "bob", "event"=> "comment", "detail"=> "Hi, everyone!"}
    $time2 = "1393709495"
    $data2 = {"username"=> "bobiert", "event"=> "leave-room", "detail"=> nil}
    $time3 = "1393709466"
    $data3 = {"username"=> "suzie", "event"=> "enter-room", "detail"=> nil}
    $time4 = "1387497600"
    $data4 = {"username"=> "tim", "event"=> "high-five", "detail"=> "bob"}
    $time5 = "1393701495"
    $data5 = {"username"=> "bob", "event"=> "leave-room", "detail"=> nil}

    item1 = LogItem.new($time1, $data1)
    item2 = LogItem.new($time2, $data2)
    item3 = LogItem.new($time3, $data3)
    item4 = LogItem.new($time4, $data4)
    item5 = LogItem.new($time5, $data5)
    @log_item_list= item1, item2, item3, item4, item5
    @log_item_list.sort!

  end

  def agg_items_by_time(unit='minute')
    @unit_time= unit
    if @unit_time
      @agg_items = []
      time_agg = set_time_agg()
    else
      return nil
    end

    cur_agg_item = LogItem.new
    cur_agg_item.time= @log_item_list.first.time
    if cur_agg_item.time
      @log_item_list.each do |item|
        if time_agg
          if item.time.to_i - cur_agg_item.time.to_i > time_agg
            @agg_items.push(cur_agg_item)
            cur_agg_item = LogItem.new
            cur_agg_item.time= item.time
          end
          if cur_agg_item.data[item.data["event"]] == 1  
            cur_agg_item.data[item.data["event"]] += 1 
          else 
            cur_agg_item.data[item.data["event"]]= 1
          end
        end
      end
    end
    @agg_items.push(cur_agg_item)
  end
  def set_time_agg(unit=nil)
    @unit_time= unit if unit != nil
    val = $units_time[@unit_time]
    val
  end
  def print_agg_items
    @agg_items.each do |item|
      puts" #{item.time_print(@unit_time)}:"
      item.data.each { |event, count| puts " #{count} #{$chat_events[event]} "}
      puts "\n"
    end
  end 
  def help_text 
    puts "Valid commands:\n"
    puts "history - will show all history of chat"
    puts "aggregate ['minute', 'hour', 'day']- will show all history of chat by unit of time given as parameter"
    puts "minute- will show all history of chat by minute"
    puts "hour- will show all history of chat by hours"
    puts "days - will show all history of chat by days"
  end
end

