class PassengerCar < Car
  CAR_TYPE = "Passenger"
  UNITS = "Seats"

  def get_car_type
    CAR_TYPE
  end

  def take_place
    @used_place += 1 if free_place > 0
  end
end