# frozen_string_literal: true

require_relative 'validation'

class User < Player
  include Validation
  FORMAT = /^[A-Z]{1}[a-z]{2,7}/.freeze

  validate :name, :presence
  validate :name, :format, FORMAT
  validate :name, :type, String

  def name=(name)
    @name = name
    validate!
  end
end
