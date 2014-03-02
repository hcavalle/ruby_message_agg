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
end
