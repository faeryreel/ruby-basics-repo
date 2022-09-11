class CargoCar < Car
  CAR_TYPE = "Cargo"

  attr_accessor :total_volume

  def initialize(number, manufacturer_name, total_volume)
    super(number, manufacturer_name)
    @total_volume = total_volume
    @empty_volume = @total_volume
  end

  def get_car_type
    CAR_TYPE
  end

  def take_volume(volume)
    if all_volume_taken? == false
      take_volume!(volume)
    end
  end

  def get_taken_volume
    @total_volume - @empty_volume
  end

  def get_empty_volume
    @empty_volume
  end

  private

  attr_accessor :empty_volume

  def all_volume_taken?
    self.empty_volume == 0
  end

  def take_volume!(volume)
    if enough_volume_left?(volume)
      self.empty_volume -= volume
    end
  end

  def enough_volume_left?(volume)
    self.empty_volume >= volume
  end
end