class Train
  include InstanceCounter
  include ManufacturerName
  include Validation

  attr_reader :number, :speed, :cars, :route, :current_station, :previous_station, :next_station
  attr_writer :current_station, :previous_station, :next_station

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number, manufacturer_name)
    @number = number
    @manufacturer_name = manufacturer_name
    @cars = []
    @speed = 0
    @@trains << self
    self.register_instance
    validate!
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def delete_car(car)
    if is_stopped?
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
    if is_terminal?
      raise "\nThe train can't move forward because it is at the terminal station of the route."
    else
      move_forward!
    end
  end

  def move_backwards
    if is_initial?
      raise "\nThe train can't move backwards because it is at the initial station of the route."
    else
      move_backwards!
    end
  end

  private

  attr_writer :cars, :route

=begin
Метод, проверяющий, стоит ли поезд, используется только внутренним методом
классов PassengerTrain и CargoTrain и не будет вызываться пользователем,
поэтому его можно определить как private.
=end

  def is_stopped?
    self.speed.zero?
  end

=begin
Метод, добавляющий объект вагона непосредственно в массив вагонов внутри
объекта поезда, вызывается только внутри классов PassengerTrain и CargoTrain
и не будет вызываться пользователем, поэтому его можно определить как private.
Изменить массив вагонов вне класса нельзя.
=end 

  def add_car!(car)
    self.cars << car
  end

=begin
Метод, удаляющий объект вагона непосредственно из массива вагонов внутри
объекта поезда, вызывается только внутри класса Train и не будет вызываться пользователем,
поэтому его можно определить как private. Изменить массив вагонов вне класса нельзя.
=end

  def delete_car!(car)
    self.cars.delete(car)
  end

=begin
Метод, проверяющий, не является ли станция конечной, используется только внутри класса
при попытке переместить поезд вперед по маршруту. Вызываться пользователем он не будет,
поэтому его можно определить как private.
=end

  def is_terminal?
    self.current_station == self.route.stations[-1]
  end

=begin
Метод, изменяющий предыдущую для поезда станцию, используется только внутри класса
(более того — только в секции private). Изменить предыдущую станцию извне нельзя.
=end

  def change_previous_station
    self.previous_station = self.current_station
  end

=begin
Метод, позволяющий определить индекс текущей станции поезда в массиве станций,
из которых состоит маршрут, используется только внутренними методами,
поэтому его можно определить как private.
=end

  def current_station_index
    self.route.stations.index(self.current_station)
  end

=begin
Метод, перемещающий поезд на одну станцию вперед, используется только внутри класса Train
и не будет вызываться пользователем, поэтому его можно определить как private.
=end

  def move_forward!
    change_previous_station
    self.current_station = self.route.stations[current_station_index + 1]
    if is_terminal?
      self.next_station = nil
    else
      self.next_station = self.route.stations[current_station_index + 1]
    end
  end

=begin
Метод, проверяющий, не является ли станция начальной, используется только внутри класса
при попытке переместить поезд назад по маршруту. Вызываться пользователем он не будет,
поэтому его можно определить как private.
=end

  def is_initial?
    self.current_station == self.route.stations[0]
  end

=begin
Метод, перемещающий поезд на одну станцию назад, используется только внутри класса Train
и не будет вызываться пользователем, поэтому его можно определить как private.
=end

  def move_backwards!
    change_previous_station
    self.current_station = self.route.stations[current_station_index - 1]
    if is_initial?
      self.next_station = nil
    else
      self.next_station = self.route.stations[current_station_index - 1]
    end
  end
end