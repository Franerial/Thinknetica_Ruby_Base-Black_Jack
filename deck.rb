# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :card_list

  def initialize
    @card_list = generate_deck.reduce([]) { |deck, card| deck << Card.new(card[0], card[1]) }
  end

  def generate_deck
    deck_list = {}

    # generate deck for numbers
    Card::VALUES.each do |x|
      Card::SUITS.each do |y|
        deck_list["#{x}#{y}"] = x
      end
    end

    # generate deck for pictures
    Card::PICTURES.each do |x|
      Card::SUITS.each do |y|
        deck_list["#{x}#{y}"] = 10
        deck_list["#{x}#{y}"] = [1, 11] if x == 'A'
      end
    end
    deck_list
  end
end
