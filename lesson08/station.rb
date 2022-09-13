class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end
  
  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    self.register_instance
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
    if no_trains? == false && (is_cargo?(type) || is_passenger?(type))
      @trains.each { |train| puts "#{train.class::TYPE} train #{train.number}." if is_of_certain_type?(train, type) }
      no_trains_message(type)
    elsif no_trains?
      puts "There are no trains at the station."
    else
      puts "There are no #{type.downcase} trains at the station."
    end
  end

  def dispatch_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      raise "There is no such train at the station."
    end
  end

  def list_trains(&block)
    @trains.each { |train| yield(train) }
  end

  private

=begin
Метод, определяющий, есть ли на станции поезда, используется только
внутри класса при попытке вывести список поездов на станции
и не будет вызываться пользователем, поэтому его можно определить как private.
=end

  def no_trains?
    self.trains.size == 0
  end

=begin
Методы, определяющие, является ли поезд пасажирским или грузовым, используются только
внутри класса при попытке вывести список поездов на станции
и не будут вызываться пользователем, поэтому их можно определить как private.
=end 

  def is_cargo?(type)
    type.capitalize == "Cargo"
  end

  def is_passenger?(type)
    type.capitalize == "Passenger"
  end

=begin
Метод, определяющий, имеет ли поезд заданный тип, используется только
внутри класса при попытке вывести список поездов на станции
и не будет вызываться пользователем, поэтому его можно определить как private.
=end 

  def is_of_certain_type?(train, type)
    train.class::TYPE == type
  end

=begin
Метод, подсчитывающий количество поездов заданного типа на станции, используется только
другим методом в секции private и не будет вызываться пользователем,
поэтому его можно определить как private.
=end 

  def count_trains_of_certain_type(type)
    trains_count = 0
    self.trains.each { |train| trains_count += 1 if is_of_certain_type?(train, type) }
    return trains_count
  end

=begin
Метод, определяющий, есть ли на станции поезда заданного типа, используется только
другим методом в секции private и не будет вызываться пользователем,
поэтому его можно определить как private.
=end 

  def no_trains_of_certain_type?(type)
    count_trains_of_certain_type(type) == 0
  end

=begin
Метод, выводящий сообщение об отсутствии на станции поездов заданного типа, используется только
внутри класса и не будет вызываться пользователем, поэтому его можно определить как private.
=end 

  def no_trains_message(type)
    puts "There are no #{type.downcase} trains at the station." if no_trains_of_certain_type?(type)
  end
end