class Car
  include ManufacturerName
  include Validation

  attr_reader :number

  def initialize(number, manufacturer_name)
    @number = number
    @manufacturer_name = manufacturer_name
    validate!
  end
end