class Train 
  attr_accessor :route
  attr_reader :number, :type, :current_speed
  
  def initialize(number = rand(1..100), route)
    @number = number
    @route = route
    @current_speed = 0
    @stations_straight = $all_stations
    @current_station = 0
    @wagons = []
  end
  
  def add_wagon(wagon)
    @wagons << wagon if @current_speed.zero? && @type == wagon.type
  end 

  def delete_wagon(wagon)
    @wagons.delete(wagon)  
  end

  def current_num_wagons
    puts @wagons.size
  end

  def up_speed
    @current_speed += 10
  end
  
  def slow_down
    @current_speed = 0
  end

  def next_station
    return if @stations_straight.size <= 1
    return if @current_station + 1 >= @stations_straight.size

    @stations_straight[@current_station + 1]
  end
  
  def previous_station
    return if @stations_straight.empty?
    return unless @current_station.positive?

    @stations_straight[@current_station - 1]
  end
  
  def up_action
    return unless next_station

    @current_station += 1
    {current_station:  @current_station}
  end

  def down_action
    return unless previous_station

    @current_station -= 1
    {current_station:  @current_station}
  end
end
