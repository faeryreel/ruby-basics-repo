# frozen_string_literal: true

class PassengerTrain < Train
  TYPE = 'Passenger'

  def add_car(car)
    if stopped? && passenger_car?(car)
      add_car!(car)
    elsif stopped? == false
      raise "You can't add a car because the train is moving!"
    else
      raise 'You can only add passenger cars to a passenger train.'
    end
  end

  private

  # Метод, определяющий, является ли вагон пассажирским, используется только
  # внутри класса при попытке добавить вагон и не будет вызываться пользователем,
  # поэтому его можно определить как private.

  def passenger_car?(car)
    car.class::CAR_TYPE == 'Passenger'
  end
end
