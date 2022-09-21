# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  def initialize(initial_station, terminal_station)
    @stations = []
    @stations[0] = initial_station
    @stations[1] = terminal_station
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if initial?(station) == false && terminal?(station) == false
      @stations.delete(station)
    elsif initial?(station)
      raise "You can't delete the initial station!"
    else
      raise "You can't delete the terminal station!"
    end
  end

  def list_stations
    puts "All stations in the route #{@stations[0].name}–#{@stations[-1].name}:\n\n"
    @stations.each { |station| puts station.name }
  end

  private

  # Методы, проверяющие, не является ли станция, которую требуется удалить,
  # начальной или конечной станцией маршрута, используются только внутри объекта,
  # поэтому их можно определить как private.

  def initial?(station)
    stations.index(station).zero?
  end

  def terminal?(station)
    stations.index(station) == -1
  end
end
