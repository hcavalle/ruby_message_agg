class Log
  include Comparable
  attr :log_item_list

  def initialize(*args)
    @log_item_list = [*args] 
    @log_item_list.sort!
  end
  def log_item_list=(items)
    @log_item_list =  items
    #@log_item_list.sort!
  end
  def log_item_list
    @log_item_list
  end
  def log_item(item)
    @log_item_list.push(item)
  end
  def print_log(unit=nil)
    @log_item_list.each do |item|
      print"#{item.time_print}: "
      item.data.each { |key, val| print " #{val} "}
      puts "\n"
    end
  end
end
