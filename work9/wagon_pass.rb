class PassengerWagon
  include Manufacturer
  attr_accessor :all_seats
  attr_reader :type

  @@all = []

  def self.all
    @@all
  end

  def initialize(all_seats)
    @type = 'passengers'
    @all_seats = all_seats
    @original_seats = @all_seats
    @@all << self
  end

  def take_seat
    if @all_seats >= 1
      @all_seats -= 1
      @current_taked_seats = @original_seats - @all_seats
      puts "Seat has been taked. Remaining seats: #{@all_seats}"
    else
      puts "You can't take a seat"
    end
  end

  def show_taked_seats
    puts @current_taked_seats
  end

  def free_seats
    puts @current_free_seats = @original_seats - @current_taked_seats
  end
end
