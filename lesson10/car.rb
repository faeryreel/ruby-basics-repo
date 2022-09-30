# frozen_string_literal: true

class Car
  extend Accessors

  include ManufacturerName
  include Validation

  attr_reader :number, :total_place, :used_place
  # attr_accessor_with_history :number, :manufacturer_name, :total_place, :used_place
  # strong_attr_accessor :number, Integer
  # strong_attr_accessor :manufacturer_name, String

  validate :number, :presence
  validate :number, :type, Integer
  validate :manufacturer_name, :presence
  validate :manufacturer_name, :type, String
  validate :total_place, :presence

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
