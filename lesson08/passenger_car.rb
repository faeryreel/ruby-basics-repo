class PassengerCar < Car
  CAR_TYPE = "Passenger"

  attr_accessor :total_seats

  def initialize(number, manufacturer_name, total_seats)
    super(number, manufacturer_name)
    @total_seats = total_seats
    @empty_seats = @total_seats
  end

  def get_car_type
    CAR_TYPE
  end

  def take_seat
    if all_seats_taken? == false
      take_seat!
    end
  end

  def get_taken_seats
    @total_seats - @empty_seats
  end

  def get_empty_seats
    @empty_seats
  end

  private

  attr_accessor :empty_seats

  def all_seats_taken?
    self.empty_seats == 0
  end

  def take_seat!
    self.empty_seats -= 1
  end

end