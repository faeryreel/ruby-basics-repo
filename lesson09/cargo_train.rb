# frozen_string_literal: true

class CargoTrain < Train
  TYPE = 'Cargo'

  def add_car(car)
    if stopped? && cargo_car?(car)
      add_car!(car)
    elsif stopped? == false
      raise "You can't add a car because the train is moving!"
    else
      raise 'You can only add cargo cars to a cargo train.'
    end
  end

  private

  # Метод, определяющий, является ли вагон грузовым, используется только
  # внутри класса при попытке добавить вагон и не будет вызываться пользователем,
  # поэтому его можно определить как private.

  def cargo_car?(car)
    car.class::CAR_TYPE == 'Cargo'
  end
end
