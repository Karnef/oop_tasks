require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  attr_reader :all_trains, :st_name

  NAME_STATION_FORMAT = /^[a-z]{1,10}$/i

  @@all = []

  def self.all
    @@all
  end
  
  def initialize(st_name)
    @st_name = st_name
    @all_trains = []
    validate!
    register_instance
    @@all << self
  end
  
  def add_train(train)
    @all_trains << train
  end
  
  def show_type(type)
    @all_trains.select {|tr| tr.type == type}.size
  end
  
  def remove_train(train)
    return unless @all_trains.include?(train)
  
    @all_trains.delete(train)
  end 
  
  def self.each_trains(&b)
    if block_given?
      yield(@all_trains)
    end

    puts "Choose a station"
    Station.all.each_with_index do |st, i|
      puts "#{i + 1} -- #{st}"
    end
    choosed_st = gets.chomp.to_i
    
    return if Station.all[choosed_st - 1].all_trains.size == 0
  
    Station.all[choosed_st - 1].all_trains.each do |st|
      b.call(st)
    end
  end

  def valid?
    validate!
    true
  rescue RuntimeError => e 
    false
  end
  
  protected
  
  def validate!
    raise "Invalide format. Name must contain from 1 to 10 letters" if st_name !~ NAME_STATION_FORMAT
  end
end
