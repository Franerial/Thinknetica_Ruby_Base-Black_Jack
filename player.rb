# frozen_string_literal: true

require_relative 'validation'

class Player
  include Validation
  attr_accessor :total_score, :bank, :cards
  attr_reader :name

  FORMAT = /^[A-Z]{1}[a-z]{2,7}/.freeze

  validate :name, :presence
  validate :name, :format, FORMAT
  validate :name, :type, String

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
    @total_score = 0
    validate!
  end

  def add_card(card)
    cards << card
    update_total_score(card.cost)
  end

  private

  def update_total_score(card_cost)
    return self.total_score += card_cost if card_cost.instance_of?(Integer)

    possible_total_score1 = total_score + 1
    possible_total_score2 = total_score + 11

    self.total_score = if (21 - possible_total_score1 < 21 - possible_total_score2) && (possible_total_score1 <= 21)
                         possible_total_score1
                       elsif possible_total_score2 <= 21
                         possible_total_score2
                       else
                         possible_total_score1
                       end
  end
end
