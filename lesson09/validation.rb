# frozen_string_literal: true

module Validation
  TRAIN_NUMBER_FORMAT = /[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze
  VALIDATION_METHODS = {
    'Car' => %i[validate_car_number validate_manufacturer_name],
    'CargoCar' => %i[validate_car_number validate_manufacturer_name],
    'PassengerCar' => %i[validate_car_number validate_manufacturer_name],
    'Route' => [:validate_stations], 'Train' => %i[validate_train_number validate_manufacturer_name],
    'CargoTrain' => %i[validate_train_number validate_manufacturer_name],
    'PassengerTrain' => %i[validate_train_number validate_manufacturer_name],
    'Station' => [:validate_station_name]
  }.freeze

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    VALIDATION_METHODS[self.class.to_s].each { |method| send(method) }
  end

  def validate_car_number
    raise 'You should enter the car number!' if number.nil?

    if instance_of?(CargoCar)
      validate_cargo_car_number
    else
      validate_passenger_car_number
    end
  end

  def validate_cargo_car_number
    raise "Car number can't be greater than 75." if number > 75
  end

  def validate_passenger_car_number
    raise "Car number can't be greater than 20." if number > 20
  end

  def validate_manufacturer_name
    if manufacturer_name.nil?
      print "\nPlease, enter the name of the manufacturer."
      raise 'You should enter the name of the manufacturer!'
    end
    if manufacturer_name.match(/[0-9]/) || manufacturer_name.match(/\W/)
      print "\nPlease, ensure that manufacturer's name contains only Latin letters."
      raise "Manufacturer's name may only contain Latin letters."
    end
  end

  def validate_stations(initial_station, terminal_station)
    if initial_station.class != Station || terminal_station.class != Station
      raise 'To create a route, you can only use Station objects.'
    end
    raise "You can't create a route using the same station as both initial and terminal!" if same_station?(
      initial_station, terminal_station
    )
  end

  def same_station?(initial_station, terminal_station)
    initial_station == terminal_station
  end

  def validate_train_number
    if number == ''
      print "\nPlease, enter the train number."
      raise 'You should enter the train number!'
    end
    if number !~ TRAIN_NUMBER_FORMAT
      print "\nPlease, ensure the number has valid format."
      raise 'Number has invalid format.'
    end
  end

  def validate_station_name
    raise 'You should enter the name of the station!' if name.nil?
    raise 'Station name may only contain Latin letters.' if name.match(/[0-9]/) || name.match(/\W/)
  end
end
