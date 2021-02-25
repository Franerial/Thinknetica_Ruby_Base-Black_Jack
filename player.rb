# frozen_string_literal: true

require_relative 'hand'

class Player
  attr_accessor :bank
  attr_reader :name, :hand

  def initialize
    @bank = 100
    @hand = Hand.new
  end

  def add_card(card)
    hand.cards << card
    hand.update_total_score(card.cost)
  end
end
