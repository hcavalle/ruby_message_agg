class LogItem
  include Comparable
  attr :time
  attr :data
  
  def <=>(other)
    time <=> other.time
  end
  def initialize(time=Time.new, data={})
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
  def time_print(unit='minute')
    if unit == 'hour'
      print self.time.strftime("%b %d %I%p")
    elsif unit == 'minute'
      print self.time.strftime("%b %d %I:%M%p")
    elsif unit == 'day'
      print self.time.strftime("%b %d")
    end
  end
end
