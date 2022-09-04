class Car
  attr_reader :number

  include ManufacturerName

  def initialize(number, manufacturer_name)
    @number = number
    @manufacturer_name = manufacturer_name
  end
end