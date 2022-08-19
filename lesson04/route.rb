class Route
  attr_reader :stations

  def initialize(initial_station, terminal_station)
    @stations = []
    @stations[0] = initial_station
    @stations[1] = terminal_station
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if @stations.index(station) != 0 && @stations.index(station) != @stations.size - 1
      @stations.delete(station)
    elsif @stations.index(station) == 0
      puts "Удалить начальную станцию нельзя!"
    else
      puts "Удалить конечную станцию нельзя!"
    end
  end

  def list_stations
    puts "Список станций в маршруте:\n\n"
    @stations.each { |station| puts station.name}
  end
end