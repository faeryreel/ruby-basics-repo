class CargoTrain < Train
  TYPE = "Cargo"

  def get_type
    TYPE
  end

  def add_car(car)
    if is_stopped? && is_cargo_car?(car)
      add_car!(car)
    elsif is_stopped? == false
      puts "\nYou can't add a car because the train is moving!"
    else
      puts "\nYou can only add cargo cars to a cargo train."
    end
  end

  private

=begin
Метод, определяющий, является ли вагон грузовым, используется только
внутри класса при попытке добавить вагон и не будет вызываться пользователем,
поэтому его можно определить как private.
=end

  def is_cargo_car?(car)
    car.get_car_type == "Cargo"
  end
end