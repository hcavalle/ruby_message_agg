require_relative 'logitem'
require_relative 'log'
require_relative 'chatlog'
require 'test/unit'
require 'date'

$time1 = "1393709493"
$data1 = {"username"=> "bob", "event"=> "comment", "detail"=> "Hi, everyone!"}
$time2 = "1393709495"
$data2 = {"username"=> "bobiert", "event"=> "leave", "detail"=> nil}

class TestChatLog < Test::Unit::TestCase

  def test_all()
    message "Initializing #{self.class.name}...\n"
  end
end

class LogItemTest < TestChatLog #Test::Unit::TestCase
  attr :item

  def init_item() 
    time = $time1
    data = $time2
    @item = LogItem.new(time, data)
  end
  def test_init()
    self.init_item()
    assert_kind_of LogItem, item
  end
  def test_set_get_log_item()
    self.init_item()
    time = $time2
    data = $time2
    @item.set(time, data)

    assert_equal @item.time, Time.at(time.to_i)
    #assert_equal @item.date, DateTime.strptime(time,'%s')
    assert_equal @item.data, data
  end
end

class LogTest < TestChatLog
  attr :_log
  attr :item1
  attr :item2

  def init_log_list
    @item1 = LogItem.new($time1, $data1)
    @item2 = LogItem.new($time2, $data2)
    @_log = Log.new(@item1, @item2)
  end
  def test_log_init
    self.init_log_list
    assert_kind_of Log, @_log
    assert_equal @_log.log_item_list.first(), @item1
  end
  def test_set_get_log_items
    self.init_log_list
    temp_list = Log.new(@item2, @item1)
    temp_list.log_item_list= @_log.log_item_list

    assert_equal temp_list.log_item_list.first, @_log.log_item_list.first
    assert_kind_of LogItem, @_log.log_item_list.first
  end
  def test_print_log
    self.init_log_list
    #message = ""
    assert_output { @_log.print_log }
  end
end

class ChatLogTest < LogTest
  attr :chatlog

  def init_chat_log
    @item1 = LogItem.new($time1, $data1)
    @item2 = LogItem.new($time2, $data2)
    @chatlog = ChatLog.new(@item1, @item2)
  end
  def test_seed
    self.init_chat_log
    @chatlog.seed_data
    assert_kind_of LogItem, @chatlog.log_item_list.first
  end
  def test_set_unit_time
    self.init_chat_log
    assert_equal 60, @chatlog.set_time_agg('minute') 
    assert_equal 60*60, @chatlog.set_time_agg('hour') 
    assert_equal 60*60*24, @chatlog.set_time_agg('day') 
  end
  def test_agg
    self.init_chat_log
    @chatlog.agg_items_by_time('minute')
    assert_kind_of LogItem, @chatlog.agg_items.first
    assert_equal @chatlog.agg_items.first.data['comment'], 1
    assert_output { @chatlog.print_agg_items }
  end
end
