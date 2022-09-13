require_relative 'instance_counter.rb'
require_relative 'manufacturer_name.rb'
require_relative 'validation.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'car.rb'
require_relative 'passenger_car.rb'
require_relative 'cargo_car.rb'
require_relative 'route.rb'
require_relative 'station.rb'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def show_menu
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
    puts "13. List train cars"
    puts "14. Take seat or volume in a car\n\n"
  end

  def create_station
    print "\nEnter the name of the station: "
    @stations << Station.new(gets.chomp)
    print "\nStation #{@stations[-1].name} is successfully created."
  end

  def create_train
    begin
      print "\nEnter the number of the train: "
      train_number = gets.chomp
      print "Enter the name of the train manufacturer: "
      manufacturer_name = gets.chomp
      print "Enter the type of the train (passenger or cargo): "
      train_type = gets.chomp
      if train_type.capitalize == "Passenger"
        @trains << PassengerTrain.new(train_number, manufacturer_name)
      else
        @trains << CargoTrain.new(train_number, manufacturer_name)
      end
      print "\n#{train_type.capitalize} train #{train_number} is successfully created. Manufacturer: #{manufacturer_name}."
    rescue
      retry
    end
  end

  def find_station_by_name(name)
    return @stations.find { |station| station.name == name }
  end

  def create_route
    print "\nEnter the name of the initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the terminal station: "
    terminal_station_name = gets.chomp
    @routes << Route.new(find_station_by_name(initial_station_name), find_station_by_name(terminal_station_name))
    print "\nRoute #{initial_station_name}–#{terminal_station_name} is successfully created."
  end

  def find_route_by_stations(initial_station_name, terminal_station_name)
    return @routes.index(@routes.find { |route| route.stations[0].name == initial_station_name && route.stations[-1].name == terminal_station_name})
  end

  def add_station_to_route
    print "\nEnter the name of the station: "
    station_name = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    @routes[find_route_by_stations(initial_station_name, terminal_station_name)].add_station(find_station_by_name(station_name))
    puts "Station #{station_name} is successfully added to the route #{initial_station_name}–#{terminal_station_name}."
  end

  def delete_station_from_route
    print "\nEnter the name of the station: "
    station_name = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    @routes[find_route_by_stations(initial_station_name, terminal_station_name)].delete_station(find_station_by_name(station_name))
    puts "\nStation #{station_name} is successfully deleted from the route #{initial_station_name}–#{terminal_station_name}."
  end

  def find_train_by_number(number)
    return @trains.index(@trains.find { |train| train.number == number })
  end

  def assign_route
    print "\nEnter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    @trains[find_train_by_number(train_number)].take_route(@routes[find_route_by_stations(initial_station_name, terminal_station_name)])
    find_station_by_name(initial_station_name).receive_train(@trains[find_train_by_number(train_number)])
    puts "\nRoute #{initial_station_name}–#{terminal_station_name} is successfully assigned to train #{train_number}."
  end

  def add_car_to_train
    print "\nEnter the number of the car: "
    car_number = gets.chomp.to_i
    print "Enter the type of the car (passenger or cargo): "
    car_type = gets.chomp
    print "Enter the name of the car manufacturer: "
    manufacturer_name = gets.chomp
    if car_type.capitalize == "Passenger"
      print "Enter number of seats in the car: "
      total_place = gets.chomp.to_i
      car = PassengerCar.new(car_number, manufacturer_name, total_place)
    else
      print "Enter car volume: "
      total_place = gets.chomp.to_i
      car = CargoCar.new(car_number, manufacturer_name, total_place)
    end
    print "Enter the number of the train: "
    train_number = gets.chomp
    @trains[find_train_by_number(train_number)].add_car(car)
    puts "\nCar ##{car_number} is successfully added to train ##{train_number}."
  end

  def delete_car_from_train
    print "\nEnter the number of the car: "
    car_number = gets.chomp.to_i
    print "Enter the number of the train: "
    train_number = gets.chomp
    car = @trains[find_train_by_number(train_number)].cars.find { |car| car.number == car_number }
    @trains[find_train_by_number(train_number)].delete_car(car)
  end

  def move_train_forward
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    @trains[find_train_by_number(train_number)].move_forward
    find_station_by_name(@trains[find_train_by_number(train_number)].current_station.name).receive_train(@trains[find_train_by_number(train_number)])
    find_station_by_name(@trains[find_train_by_number(train_number)].previous_station.name).dispatch_train(@trains[find_train_by_number(train_number)])
  end

  def move_train_backwards
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    print "Enter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    @trains[find_train_by_number(train_number)].move_backwards
    find_station_by_name(@trains[find_train_by_number(train_number)].current_station.name).receive_train(@trains[find_train_by_number(train_number)])
    find_station_by_name(@trains[find_train_by_number(train_number)].previous_station.name).dispatch_train(@trains[find_train_by_number(train_number)])
  end

  def list_all_stations
    print "\nEnter the name of the route initial station: "
    initial_station_name = gets.chomp
    print "Enter the name of the route terminal station: "
    terminal_station_name = gets.chomp
    @routes[find_route_by_stations(initial_station_name, terminal_station_name)].list_stations
  end

  def list_trains
    print "\nEnter the name of the station: "
    station_name = gets.chomp
    find_station_by_name(station_name).list_trains { |train| puts "Train #: #{train.number}. Train type: #{train.class::TYPE}. Number of cars: #{train.cars.size}." }
    # print "Enter the type of trains you'd like to list (all, passenger or cargo): "
    # type = gets.chomp.capitalize
    # if type == "All"
    #   find_station_by_name(station_name).list_all_trains
    # else
    #   find_station_by_name(station_name).trains_by_type(type)
    # end
  end

  def list_cars
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    @trains[find_train_by_number(train_number)].list_cars { |car| puts "Car #: #{car.number}. Car type: #{car.class::CAR_TYPE}. #{car.class::UNITS} empty: #{car.free_place}. #{car.class::UNITS} taken: #{car.used_place}." }
  end

  def take_seat_or_volume
    print "\nEnter the number of the train: "
    train_number = gets.chomp
    print "Enter the number of the car: "
    car_number = gets.chomp.to_i
    if @trains[find_train_by_number(train_number)].class::TYPE == "Passenger"
      find_car_by_number(@trains[find_train_by_number(train_number)], car_number).take_place
      print "\nThe seat is successfully taken."
    else
      print "Enter the volume you'd like to take: "
      volume = gets.chomp.to_i
      find_car_by_number(@trains[find_train_by_number(train_number)], car_number).take_place(volume)
      print "\nThe volume is successfully taken."
    end
  end

  def find_car_by_number(train, car_number)
    return train.cars.find { |car| car.number == car_number }
  end

  def start
    loop do

      show_menu

      n = gets.chomp.to_i

      case n
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          add_station_to_route
        when 5
          delete_station_from_route
        when 6
          assign_route
        when 7
          add_car_to_train
        when 8
          delete_car_from_train
        when 9
          move_train_forward
        when 10
          move_train_backwards
        when 11
          list_all_stations
        when 12
          list_trains
        when 13
          list_cars
        when 14
          take_seat_or_volume
        else break
      end

      print "\nEnter any number to return to the menu. Enter 0 to exit.\n\n"

      break if gets.chomp.to_i == 0
    end
  end
end

Main.new.start