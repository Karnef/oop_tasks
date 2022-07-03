class CargoWagon
  include Manufacturer
  attr_accessor :wagon_volume
  attr_reader :type
    
  @@all = []

  def self.all
    @@all
  end

  def initialize(wagon_volume)
    @type = "cargo"
    @wagon_volume = wagon_volume
    @original_vol = @wagon_volume
    @@all << self
  end

  def take_wag_volume(num)
    if num < @wagon_volume
      @wagon_volume = @wagon_volume - num
      @taked_wag_volume = @original_vol - @wagon_volume
      puts "Volume has been taked. Remaining volume: #{@wagon_volume}"
    else
      puts "Volume is greater than allowed"
    end
  end

  def show_taked_volume
    puts @taked_wag_volume
  end

  def show_current_volume
    puts @current_wag_volume = @original_vol - @taked_wag_volume
  end
end
