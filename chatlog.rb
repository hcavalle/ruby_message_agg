class ChatLog < Log
  attr :agg_items
  chat_events = ["enter-room" => "person(s) entered room", "leave-room"=> "person(s) left the room", "comment"=>"comments", "high-five"=>"high fives between users"]

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
    if unit 
      @agg_items = []
      time_agg = set_time_agg(unit)
    else
      return nil
    end

    cur_agg_item = @log_item_list.first
    @log_item_list.each do |item|
      if time_agg
        next_time = item.time
        if next_time - cur_agg_item.time > time_agg
          @agg_items.push(cur_agg_item)
          cur_agg_item = item
          puts cur_agg_item.time #+ ": "
        end
          cur_agg_item.data[item.data["event"]]+= 1
      end
    end
  end
  def set_time_agg(unit)
    if unit == 'minute'
      60
    else if unit == 'hour'
      60*60
    else if unit == 'day'
      60*60*24
    end
  end
  def print_agg_items
    @agg.items.each do |item|
      puts item.time_print #+ ": "
      item.data.each { |event, count| puts " #{count} #{self.chat_events[event]} "}
    end
  end 
end
end
end

