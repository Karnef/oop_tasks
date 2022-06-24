class CargoTrain < Train

  def initialize(number, route)
    super

    @type = "cargo"
  end
end
