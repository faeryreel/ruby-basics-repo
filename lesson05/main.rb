require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_car.rb'
require_relative 'cargo_car.rb'
require_relative 'route.rb'
require_relative 'station.rb'

$stations = []
$trains = []
$routes = []

def find_station_by_name(name)
  return $stations.find { |station| station.name == name }
end

def find_route_by_stations(initial_station_name, terminal_station_name)
  return $routes.index($routes.find { |route| route.stations[0].name == initial_station_name && route.stations[-1].name == terminal_station_name})
end

def find_train_by_number(number)
  return $trains.index($trains.find { |train| train.number == number })
end

loop do
  puts "\nTo do one of the following, enter a corresponding number:"
  puts "\n1. Create a station"
  puts "2. Create a train"
  puts "3. Create a route"
  puts "4. Add station to a route"
  puts "5. Delete station from a route"
  puts "6. Assign route to a train"
  puts "7. Add car to a train"
  puts "8. Delete car from a train"
  puts "9. Move train forward on the route"
  puts "10. Move train backwards on the route"
  puts "11. List all stations on the route"
  puts "12. List trains at the station"
  print "\n"

  n = gets.chomp.to_i

  case n
  when 1
    print "\nEnter the name of the station: "
    $stations << Station.new(gets.chomp)
    print "\nStation #{$stations[-1].name} is successfully created."
  when 2
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    print "Enter the type of the train (passenger or cargo): "
    train_type = gets.chomp
    if train_type.capitalize == "Passenger"
      $trains << PassengerTrain.new(train_number)
    else
      $trains << CargoTrain.new(train_number)
    end
    print "\n#{train_type.capitalize} train #{train_number} is successfully created."
  when 3
    print "\nEnter the name of the initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the terminal station: "
    terminal_station_name = gets.chomp
    $routes << Route.new(find_station_by_name(initial_station_name), find_station_by_name(terminal_station_name))
    print "\nRoute #{initial_station_name}–#{terminal_station_name} is successfully created."
  when 4
    print "\nEnter the name of the station: "
    station_name = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    $routes[find_route_by_stations(initial_station_name, terminal_station_name)].add_station(find_station_by_name(station_name))
    puts "Station #{station_name} is successfully added to the route #{initial_station_name}–#{terminal_station_name}."
  when 5
    print "\nEnter the name of the station: "
    station_name = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    $routes[find_route_by_stations(initial_station_name, terminal_station_name)].delete_station(find_station_by_name(station_name))
    puts "\nStation #{station_name} is successfully deleted from the route #{initial_station_name}–#{terminal_station_name}."
  when 6
    print "\nEnter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    $trains[find_train_by_number(train_number)].take_route($routes[find_route_by_stations(initial_station_name, terminal_station_name)])
    find_station_by_name(initial_station_name).receive_train($trains[find_train_by_number(train_number)])
    puts "\nRoute #{initial_station_name}–#{terminal_station_name} is successfully assigned to train #{train_number}."
  when 7
    print "\nEnter the number of the car: "
    car_number = gets.chomp.to_i
    print "Enter the type of the car (passenger or cargo): "
    car_type = gets.chomp
    if car_type.capitalize == "Passenger"
      car = PassengerCar.new(car_number)
    else
      car = CargoCar.new(car_number)
    end
    print "Enter the number of the train: "
    train_number = gets.chomp
    $trains[find_train_by_number(train_number)].add_car(car)
  when 8
    print "\nEnter the number of the car: "
    car_number = gets.chomp.to_i
    print "Enter the number of the train: "
    train_number = gets.chomp
    car = $trains[find_train_by_number(train_number)].cars.find { |car| car.number == car_number }
    $trains[find_train_by_number(train_number)].delete_car(car)
  when 9
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    $trains[find_train_by_number(train_number)].move_forward
    find_station_by_name($trains[find_train_by_number(train_number)].current_station.name).receive_train($trains[find_train_by_number(train_number)])
    find_station_by_name($trains[find_train_by_number(train_number)].previous_station.name).dispatch_train($trains[find_train_by_number(train_number)])
  when 10
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    $trains[find_train_by_number(train_number)].move_backwards
    find_station_by_name($trains[find_train_by_number(train_number)].current_station.name).receive_train($trains[find_train_by_number(train_number)])
    find_station_by_name($trains[find_train_by_number(train_number)].previous_station.name).dispatch_train($trains[find_train_by_number(train_number)])
  when 11
    print "\nEnter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    $routes[find_route_by_stations(initial_station_name, terminal_station_name)].list_stations
  when 12
    print "\nEnter the name of the station: "
    station_name = gets.chomp
    print "Enter the type of trains you'd like to list (all, passenger or cargo): "
    type = gets.chomp.capitalize
    if type == "All"
      find_station_by_name(station_name).list_all_trains
    else
      find_station_by_name(station_name).trains_by_type(type)
    end
  else break
  end

  print "\nEnter any number to return to the menu. Enter 0 to exit.\n\n"

  break if gets.chomp.to_i == 0
end