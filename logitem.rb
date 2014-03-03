class LogItem
  include Comparable
  attr :time
  attr :data
  
  def <=>(other)
    time <=> other.time
  end
  def initialize(time=0, data={})
    @time = time
    @data = data
  end
  def set(time, data)
    @time = time
    @data = data
  end
  #def date()
  #  DateTime.strptime(@time,'%s')
  #end
  def time()
    Time.at(@time.to_i)
  end
  def time= time
    @time = time
  end
  def time_print(zone=nil)
    puts self.time
    #puts time
  end
end
