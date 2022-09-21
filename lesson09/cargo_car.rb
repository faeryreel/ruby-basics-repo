# frozen_string_literal: true

class CargoCar < Car
  CAR_TYPE = 'Cargo'
  UNITS = 'Volume'

  def take_place(volume)
    @used_place += volume if free_place >= volume
  end
end
