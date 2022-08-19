class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @all_trains = []
    @cargo_trains = []
    @passenger_trains = []
  end

  def receive_train(train)
    @all_trains << train
    if train.type.capitalize == "Cargo"
      @cargo_trains << train
    else
      @passenger_trains << train
    end
  end

  def list_all_trains
    if @all_trains.size != 0
      puts "Список всех поездов на станции:\n\n"
      @all_trains.each { |train| puts "Поезд № #{train.number}." }
      puts "\nКоличество поездов на станции: #{@all_trains.size}."
    else
      puts "На станции нет поездов."
    end
  end

  def list_cargo_trains
    if @cargo_trains.size != 0
      puts "Список грузовых поездов на станции:\n\n"
      @cargo_trains.each { |train| puts "Грузовой поезд № #{train.number}." }
      puts "\nКоличество грузовых поездов на станции: #{@cargo_trains.size}."
    else
      puts "На станции нет грузовых поездов."
    end
  end

  def list_passenger_trains
    if @passenger_trains.size != 0
      puts "Список пассажирских поездов на станции:\n\n"
      @passenger_trains.each { |train| puts "Пассажирский поезд № #{train.number}."}
      puts "\nКоличество пассажирских поездов на станции: #{@passenger_trains.size}."
    else
      puts "На станции нет пассажирских поездов."
    end
  end

  def dispatch_train(train)
    if @all_trains.include?(train)
      @all_trains.delete(train)
      if @cargo_trains.include?(train)
        @cargo_trains.delete(train)
      else
        @passenger_trains.delete(train)
      end
    else
      puts "На станции нет такого поезда."
    end
  end
end