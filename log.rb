class Log
  include Comparable
  attr :log_item_list

  def initialize(*args)
    @log_item_list = [*args] 
  end
  def log_item_list=(items)
    @log_item_list =  items
  end
  def log_item_list
    @log_item_list
  end
  def log_item(item)
    @log_item_list.push(item)
  end
  def print_log(granular=nil)
    @log_item_list.each do |item|
      puts item.time 
      item.data.each { |text| puts " #{text} "}
    end
  end
end
