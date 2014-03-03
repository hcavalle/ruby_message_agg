class ChatLog < Log
  attr :agg_items
  $chat_events = {"enter-room" => "person(s) entered room", "leave-room"=> "person(s) left the room", "comment"=>"comments", "high-five"=>"high fives between users"}
  $units_time = ["minute"=> 60, "hour"=> 60*60, "day" => 60*60*24]

  def seed_data
    #from db
    #from file

    #set statically
    $time1 = "1393709493"
    $data1 = {"username"=> "bob", "event"=> "comment", "detail"=> "Hi, everyone!"}
    $time2 = "1393709495"
    $data2 = {"username"=> "bobiert", "event"=> "leave", "detail"=> nil}

    @item1 = LogItem.new($time1, $data1)
    @item2 = LogItem.new($time2, $data2)
    @log_item_list= @item1, @item2

  end

  def agg_items_by_time(unit='minute')
    self.seed_data unless @log_item_list

    if unit 
      @agg_items = []
      time_agg = set_time_agg(unit)
    else
      return nil
    end

    cur_agg_item = LogItem.new
    cur_agg_item.time= @log_item_list.first.time
    if cur_agg_item.time
      @log_item_list.each do |item|
        if time_agg
          if item.time - cur_agg_item.time > time_agg
            @agg_items.push(cur_agg_item)
            cur_agg_item.time= item.time
            puts cur_agg_item.time #+ ": "
          end
          if cur_agg_item.data[item.data["event"]].instance_of? Integer  
            cur_agg_item.data[item.data["event"]]+= 1 
          else 
            cur_agg_item.data[item.data["event"]]= 1
          end
        end
      end
    end
    @agg_items.push(cur_agg_item)
  end
  def set_time_agg(unit)
    val = nil
    if unit == 'minute'
      val = 60
    elsif unit == 'hour'
      val = 60*60
    elsif unit == 'day'
      val = 60*60*24
    end
    val
  end
  def print_agg_items
    @agg_items.each do |item|
      puts item.time_print #+ ": "
      item.data.each { |event, count| puts " #{count} #{$chat_events[event]} "}
    end
  end 
  def help_text 
    puts "Valid commands:\n"
    puts "history - will show all history of chat"
    puts "minutes - will show all history of chat by minute"
    puts "hours - will show all history of chat by hours"
    puts "days - will show all history of chat by days"
  end
end

