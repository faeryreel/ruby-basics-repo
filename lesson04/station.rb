class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def list_all_trains
    if @trains.size != 0
      puts "List of all trains at the station:\n\n"
      @trains.each { |train| puts "Train #{train.number}." }
      puts "\nNumber of trains at the station: #{@trains.size}."
    else
      puts "There are no trains at the station."
    end
  end

  def trains_by_type(type)
    trains_count = 0
    puts "List of all #{type.downcase} trains at the station:\n\n"
    if @trains.size != 0 && (type.capitalize == "Cargo" || type.capitalize == "Passenger")
      @trains.each do |train|
        if train.type.capitalize == type.capitalize
          puts "#{type.capitalize} train #{train.number}."
          trains_count += 1
        end
      end
      if trains_count != 0
        puts "\nNumber of #{type.downcase} trains at the station: #{trains_count}."
      else
        puts "There are no #{type.downcase} trains at the station."
      end
    elsif @trains.size == 0
      puts "There are no trains at the station."
    else
      puts "There are no #{type.downcase} trains at the station."
    end
  end

  def dispatch_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts "There is no such train at the station."
    end
  end
end