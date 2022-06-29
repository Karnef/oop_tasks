require_relative 'instance_counter.rb'

class Route
  include InstanceCounter

  attr_reader :start_station, :end_station, :mid_stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @all_stations = [@start_station, @end_station]
    register_instance
  end
  
  def add_middle_st(station)
    @all_stations.insert(@all_stations.length - 1, station)
  end

  def remove_station(station)
    return unless @all_stations.include?(station)

    @all_stations.delete(station)
  end

  private #not set in the interface

  attr_accessor :start_station, :end_station

  def mid_stations
    @all_stations[1..-2]
  end

end
