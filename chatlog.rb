require_relative 'log'

class ChatLog < Log
  attr :agg_items
  chat_events = ["enter-room" => "person(s) entered room", "leave-room"=> "person(s) left the room", "comment"=>"comments", "high-five"=>"high fives between users"]

  def seed_chat_data
  
  end

  def agg_items_by_time(unit='minute')
    if unit 
      @agg_items = []
      time_agg = set_time_agg(unit)
    else
      return nil
    end

    curr_agg_item = @log_item_list.first
    @log_item_list.each do |item|
      if time_agg
        next_time = item.time
        if next_time - cur_agg_item.time > time_agg
          @agg_items.push(cur_agg_item)
          cur_agg_item = item
          puts cur_agg_item.time #+ ": "
        end
          item.data['event']
          cur_agg_item.data[item.data['event']]+= 1
        end
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
