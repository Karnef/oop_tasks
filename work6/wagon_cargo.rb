class CargoWagon
  include Manufacturer

  attr_reader :type
    
  def initialize
    @type = "cargo"
  end
end
