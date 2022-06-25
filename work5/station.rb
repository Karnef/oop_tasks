require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  attr_reader :all_trains, :st_name

  @@all = []

  def self.all
    @@all
  end
  
  def initialize(st_name)
    @st_name = st_name
    @all_trains = []
    register_instance
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
end
