class PassengerTrain < Train
  attr_reader :type
  
  def initialize(number, route)
    super

    @type = "passengers"
  end
end
