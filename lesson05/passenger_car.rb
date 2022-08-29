class PassengerCar
  attr_reader :number
  CAR_TYPE = "Passenger"

  def initialize(number)
    @number = number
  end

  def get_car_type
    CAR_TYPE
  end
end