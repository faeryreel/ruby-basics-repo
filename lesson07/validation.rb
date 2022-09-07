module Validation
  TRAIN_NUMBER_FORMAT = /[a-b0-9]{3}-?[a-b0-9]{2}$/i

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    if self.class == Car || self.class == CargoCar || self.class == PassengerCar
      validate_car_number
      validate_manufacturer_name
    elsif self.class == Route
      validate_stations(self.stations[0], self.stations[-1])
    elsif self.class == Train || self.class == CargoTrain || self.class == PassengerTrain
      validate_train_number
      validate_manufacturer_name
    else
      validate_station_name
    end
  end

  def validate_car_number
    raise "You should enter the car number!" if self.number.nil?
    if self.class == CargoCar
      validate_cargo_car_number
    else
      validate_passenger_car_number
    end
  end

  def validate_cargo_car_number
    raise "Car number can't be greater than 75." if self.number > 75
  end

  def validate_passenger_car_number
    raise "Car number can't be greater than 20." if self.number > 20
  end

  def validate_manufacturer_name
    if self.manufacturer_name.nil?
      print "\nPlease, enter the name of the manufacturer."
      raise "You should enter the name of the manufacturer!"
    end
    if self.manufacturer_name.match(/[0-9]/) || self.manufacturer_name.match(/\W/)
      print "\nPlease, ensure that manufacturer's name contains only Latin letters."
      raise "Manufacturer's name may only contain Latin letters."
    end
  end

  def validate_stations(initial_station, terminal_station)
    raise "To create a route, you can only use Station objects." if initial_station.class != Station || terminal_station.class != Station
    raise "You can't create a route using the same station as both initial and terminal!" if is_the_same_station?(initial_station, terminal_station)
  end

  def is_the_same_station?(initial_station, terminal_station)
    initial_station == terminal_station
  end

  def validate_train_number
    if self.number == ""
      print "\nPlease, enter the train number."
      raise "You should enter the train number!"
    end
    if self.number !~ TRAIN_NUMBER_FORMAT
      print "\nPlease, ensure the number has valid format."
      raise "Number has invalid format."
    end
  end

  def validate_station_name
    raise "You should enter the name of the station!" if self.name.nil?
    raise "Station name may only contain Latin letters." if self.name.match(/[0-9]/) || self.name.match(/\W/)
  end
end