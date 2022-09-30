# frozen_string_literal: true

class Train
  extend Accessors

  include InstanceCounter
  include ManufacturerName
  include Validation

  attr_accessor :current_station, :previous_station, :next_station
  attr_reader :number, :speed, :cars, :route
  # attr_accessor_with_history :current_station, :previous_station, :next_station
  # strong_attr_accessor :current_station, Station

  validate :number, :presence
  validate :number, :format, /[a-z0-9]{3}-?[a-z0-9]{2}$/i
  validate :number, :type, String
  validate :manufacturer_name, :presence
  validate :manufacturer_name, :type, String

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number, manufacturer_name)
    @number = number
    @manufacturer_name = manufacturer_name
    validate!
    @cars = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def delete_car(car)
    if stopped?
      delete_car!(car)
    else
      raise "You can't delete a car because the train is moving!"
    end
  end

  def take_route(route)
    @route = route
    @current_station = route.stations[0]
    @previous_station = nil
    @next_station = route.stations[1]
  end

  def move_forward
    if terminal?
      raise "\nThe train can't move forward because it is at the terminal station of the route."
    else
      move_forward!
    end
  end

  def move_backwards
    if initial?
      raise "\nThe train can't move backwards because it is at the initial station of the route."
    else
      move_backwards!
    end
  end

  def list_cars
    @cars.each(&block)
  end

  private

  attr_writer :cars, :route

  # Метод, проверяющий, стоит ли поезд, используется только внутренним методом
  # классов PassengerTrain и CargoTrain и не будет вызываться пользователем,
  # поэтому его можно определить как private.

  def stopped?
    speed.zero?
  end

  # Метод, добавляющий объект вагона непосредственно в массив вагонов внутри
  # объекта поезда, вызывается только внутри классов PassengerTrain и CargoTrain
  # и не будет вызываться пользователем, поэтому его можно определить как private.
  # Изменить массив вагонов вне класса нельзя.
  # =
  def add_car!(car)
    cars << car
  end

  # Метод, удаляющий объект вагона непосредственно из массива вагонов внутри
  # объекта поезда, вызывается только внутри класса Train и не будет вызываться пользователем,
  # поэтому его можно определить как private. Изменить массив вагонов вне класса нельзя.

  def delete_car!(car)
    cars.delete(car)
  end

  # Метод, проверяющий, не является ли станция конечной, используется только внутри класса
  # при попытке переместить поезд вперед по маршруту. Вызываться пользователем он не будет,
  # поэтому его можно определить как private.

  def terminal?
    current_station == route.stations[-1]
  end

  # Метод, изменяющий предыдущую для поезда станцию, используется только внутри класса
  # (более того — только в секции private). Изменить предыдущую станцию извне нельзя.

  def change_previous_station
    self.previous_station = current_station
  end

  # Метод, позволяющий определить индекс текущей станции поезда в массиве станций,
  # из которых состоит маршрут, используется только внутренними методами,
  # поэтому его можно определить как private.

  def current_station_index
    route.stations.index(current_station)
  end

  # Метод, перемещающий поезд на одну станцию вперед, используется только внутри класса Train
  # и не будет вызываться пользователем, поэтому его можно определить как private.

  def move_forward!
    change_previous_station
    self.current_station = route.stations[current_station_index + 1]
    self.next_station = if terminal?
                          nil
                        else
                          route.stations[current_station_index + 1]
                        end
  end

  # Метод, проверяющий, не является ли станция начальной, используется только внутри класса
  # при попытке переместить поезд назад по маршруту. Вызываться пользователем он не будет,
  # поэтому его можно определить как private.

  def initial?
    current_station == route.stations[0]
  end

  # Метод, перемещающий поезд на одну станцию назад, используется только внутри класса Train
  # и не будет вызываться пользователем, поэтому его можно определить как private.

  def move_backwards!
    change_previous_station
    self.current_station = route.stations[current_station_index - 1]
    self.next_station = if initial?
                          nil
                        else
                          route.stations[current_station_index - 1]
                        end
  end
end
