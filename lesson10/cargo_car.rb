# frozen_string_literal: true

class CargoCar < Car
  CAR_TYPE = 'Cargo'
  UNITS = 'Volume'

  validate :number, :presence
  validate :number, :type, Integer
  validate :manufacturer_name, :presence
  validate :manufacturer_name, :type, String
  validate :total_place, :presence
  validate :total_place, :type, Float

  def take_place(volume)
    @used_place += volume if free_place >= volume
  end
end
