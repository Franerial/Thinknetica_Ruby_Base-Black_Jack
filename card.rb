# frozen_string_literal: true

class Card
  attr_reader :name, :cost

  def initialize(name, cost)
    @name = name
    @cost = cost
  end
end
