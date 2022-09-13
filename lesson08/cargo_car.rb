class CargoCar < Car
  CAR_TYPE = "Cargo"
  UNITS = "Volume"

  def get_car_type
    CAR_TYPE
  end

  def take_place(volume)
    @used_place += volume if free_place >= volume
  end
end