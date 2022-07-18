class CargoTrain < Train
  attr_reader :type
  
  validate :number, :presence
  validate :type, :presence
  validate :number, :format, /^[a-z\d]{3}-*[a-z\d]{2}$/i

  def initialize(number, route)
    super

    @type = 'cargo'
  end
end
