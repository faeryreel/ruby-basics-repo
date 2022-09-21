# frozen_string_literal: true

class Car
  include ManufacturerName
  include Validation

  attr_reader :number, :total_place, :used_place

  def initialize(number, manufacturer_name, total_place)
    @number = number
    @manufacturer_name = manufacturer_name
    @total_place = total_place
    validate!
    @used_place = 0
  end

  def free_place
    @total_place - @used_place
  end

  def take_place
    raise 'Not implemented!'
  end
end
