# frozen_string_literal: true

class PassengerCar < Car
  CAR_TYPE = 'Passenger'
  UNITS = 'Seats'

  validate :number, :presence
  validate :number, :type, Integer
  validate :manufacturer_name, :presence
  validate :manufacturer_name, :type, String
  validate :total_place, :presence
  validate :total_place, :type, Integer

  def take_place
    @used_place += 1 if free_place.positive?
  end
end
