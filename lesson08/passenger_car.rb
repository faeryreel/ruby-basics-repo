class PassengerCar < Car
  CAR_TYPE = "Passenger"
  UNITS = "Seats"

  def take_place
    @used_place += 1 if free_place > 0
  end
end