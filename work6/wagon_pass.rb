class PassengerWagon
  include Manufacturer

  attr_reader :type
  
  def initialize
    @type = "passengers"
  end
end
