# frozen_string_literal: true

class Dealer < Player
  NAME = 'Dealer'

  def initialize
    super
    @name = NAME
  end
end
