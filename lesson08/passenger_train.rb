class PassengerTrain < Train
  TYPE = "Passenger"

  def get_type
    TYPE
  end

  def add_car(car)
    if is_stopped? && is_passenger_car?(car)
      add_car!(car)
    elsif is_stopped? == false
      raise "You can't add a car because the train is moving!"
    else
      raise "You can only add passenger cars to a passenger train."
    end
  end

  private

=begin
Метод, определяющий, является ли вагон пассажирским, используется только
внутри класса при попытке добавить вагон и не будет вызываться пользователем,
поэтому его можно определить как private.
=end

  def is_passenger_car?(car)
    car.get_car_type == "Passenger"
  end
end