require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor :route, :number
  attr_reader :type, :current_speed, :wagons

  NUMBER_TRAIN_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/i

  validate :number, :presence
  validate :number, :format, /^[a-z\d]{3}-*[a-z\d]{2}$/i
  validate :number, :type, Train
  validate :type, :presence

  @@all = []

  def self.all
    @@all
  end

  def initialize(number, route)
    @number = number
    @route = route
    validate!
    @current_speed = 0
    @stations_straight = @all_stations
    @current_station = 0
    @wagons = []
    @@all << self
    register_instance
  end

  def self.find(number)
    Train.all.find { |tr| tr.number == number }
  end

  def add_wagon(wagon)
    @wagons << wagon if @current_speed.zero? && @type == wagon.type
  end

  def delete_wagon
    @wagons.pop
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
    { current_station: @current_station }
  end

  def down_action
    return unless previous_station

    @current_station -= 1
    { current_station: @current_station }
  end

  def each_wagons(&b)
    @wagons.each { |wag| yield wag }
  end

  def valid?
    validate!
    true
  rescue RuntimeError => e
    false
  end

  protected

  def validate!
    raise 'Invalid format' if number !~ NUMBER_TRAIN_FORMAT
  end
end
