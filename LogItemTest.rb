require_relative 'logitem'
require 'test/unit'

class TestChatLog < Test::Unit::TestCase
  def test_all()
    puts "Initializing #{self.class.name}...\n"
  end
end

class LogItemTest < TestChatLog #Test::Unit::TestCase
  attr :item
  attr :time
  attr :data

  def init_item() 
    @time = "1393709493"
    @data = {"username"=> "bob", "event"=> "comment", "detail"=> "Hi, everyone!"}
    @item = LogItem.new(time, data)
  end

  def test_init()
    self.init_item()
    assert_kind_of LogItem, item
    #puts @item.object_id ? "Item object initialized." : "Item init failed."
  end
  def test_set_get_log_item()
    self.init_item()
    @time = "1393709495"
    @data = {"username"=> "bobiert", "event"=> "leave", "detail"=> nil}
    @item.set(time, data)

    assert_equal @item.time, time
    assert_equal @item.data, data
  end

end

