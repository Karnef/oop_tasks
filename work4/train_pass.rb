class PassengerTrain < Train
  attr_reader :type
  
  def initialize(number)
    super

    @type = "passengers"
  end
end
