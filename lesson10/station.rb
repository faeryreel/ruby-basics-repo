# frozen_string_literal: true

class Station
  extend Accessors

  include InstanceCounter
  include Validation

  attr_reader :name, :trains
  # attr_accessor_with_history :name, :trains
  # strong_attr_accessor :name, String

  validate :name, :presence
  validate :name, :type, String

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def receive_train(train)
    @trains << train
  end

  def list_all_trains
    if no_trains?
      puts "\nThere are no trains at the station."
    else
      puts "\nList of all trains at the station:\n\n"
      @trains.each { |train| puts "Train #{train.number}." }
    end
  end

  def trains_by_type(type)
    puts "\nList of all #{type.downcase} trains at the station:\n\n"
    if !no_trains? && (cargo?(type) || passenger?(type))
      @trains.each { |train| puts "#{train.class::TYPE} train #{train.number}." if certain_type?(train, type) }
      no_trains_message(type)
    elsif no_trains?
      puts 'There are no trains at the station.'
    else
      puts "There are no #{type.downcase} trains at the station."
    end
  end

  def dispatch_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      raise 'There is no such train at the station.'
    end
  end

  def list_trains
    @trains.each(&block)
  end

  private

  # Метод, определяющий, есть ли на станции поезда, используется только
  # внутри класса при попытке вывести список поездов на станции
  # и не будет вызываться пользователем, поэтому его можно определить как private.

  def no_trains?
    trains.size.zero?
  end

  # Методы, определяющие, является ли поезд пасажирским или грузовым, используются только
  # внутри класса при попытке вывести список поездов на станции
  # и не будут вызываться пользователем, поэтому их можно определить как private.
  # =
  def cargo?(type)
    type.capitalize == 'Cargo'
  end

  def passenger?(type)
    type.capitalize == 'Passenger'
  end

  # Метод, определяющий, имеет ли поезд заданный тип, используется только
  # внутри класса при попытке вывести список поездов на станции
  # и не будет вызываться пользователем, поэтому его можно определить как private.
  # =
  def certain_type?(train, type)
    train.class::TYPE == type
  end

  # Метод, подсчитывающий количество поездов заданного типа на станции, используется только
  # другим методом в секции private и не будет вызываться пользователем,
  # поэтому его можно определить как private.
  # =
  def count_trains_of_certain_type(type)
    trains_count = 0
    trains.each { |train| trains_count += 1 if is_of_certain_type?(train, type) }
    trains_count
  end

  # Метод, определяющий, есть ли на станции поезда заданного типа, используется только
  # другим методом в секции private и не будет вызываться пользователем,
  # поэтому его можно определить как private.
  # =
  def no_trains_of_certain_type?(type)
    count_trains_of_certain_type(type).zero?
  end

  # Метод, выводящий сообщение об отсутствии на станции поездов заданного типа, используется только
  # внутри класса и не будет вызываться пользователем, поэтому его можно определить как private.
  # =
  def no_trains_message(type)
    puts "There are no #{type.downcase} trains at the station." if no_trains_of_certain_type?(type)
  end
end
