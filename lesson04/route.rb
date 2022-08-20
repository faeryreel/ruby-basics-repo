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
      puts "You can't delete the initial station!"
    else
      puts "You can't delete the terminal station!"
    end
  end

  def list_stations
    puts "All stations in the route:\n\n"
    @stations.each { |station| puts station.name}
  end
end