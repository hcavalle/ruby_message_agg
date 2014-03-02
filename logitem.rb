class LogItem
  include Comparable
  attr :time
  attr :data
  
  def <=>(other)
    time <=> other.time
  end
  def initialize(time, data)
    @time = time
    @data = data
  end
  def set(time, data)
    @time = time
    @data = data
  end
  def time_print(zone='utc')
    if zone == 'utc'
      puts time
      time = DateTime.strptime(@time,'%s')
    else
      time = Time.at(@time.to_i).to_datetime
    time
    end
  end
end
