class Train
  attr_reader :type, :number, :speed, :number_of_cars, :current_station, :previous_station, :next_station

  def initialize(number, type, number_of_cars)
    @number = number
    @type = type
    @number_of_cars = number_of_cars
    @speed = 0
  end

  def accelerate(speed)
    @speed = speed
  end

  def brake
    @speed = 0
  end

  def add_car
    if @speed == 0
      @number_of_cars += 1
    else
      puts "Невозможно прицепить вагон, так как поезд движется!"
    end
  end

  def delete_car
    if @speed == 0
      @number_of_cars -= 1
    else
      puts "Невозможно отцепить вагон, так как поезд движется!"
    end
  end

  def take_route(route)
    @route = route
    @current_station = route.stations[0]
    @previous_station = nil
    @next_station = route.stations[1]
  end

  def move_forward
    if @current_station != @route.stations[-1]
      @previous_station = @current_station
      @current_station = @route.stations[@route.stations.index(@current_station) + 1]
      if @route.stations.index(@current_station) != @route.stations.size - 1
        @next_station = @route.stations[@route.stations.index(@current_station) + 1]
      else
        @next_station = nil
      end
    else
      puts "Поезд не может переместиться вперед, так как находится на конечной станции маршрута."
    end
  end

  def move_backwards
    if @current_station != @route.stations[0]
      @previous_station = @current_station
      @current_station = @route.stations[@route.stations.index(@current_station) - 1]
      if @route.stations.index(@current_station) != 0
        @next_station = @route.stations[@route.stations.index(@current_station) - 1]
      else
        @next_station = nil
      end
    else
      puts "Поезд не может переместиться назад, так как находится на начальной станции маршрута."
    end
  end
end