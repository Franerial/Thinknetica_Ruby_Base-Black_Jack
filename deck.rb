# frozen_string_literal: true

class Deck
  SPADE = "\u2660".encode('utf-8')
  HEART = "\u2665".encode('utf-8')
  DIAMOND = "\u2666".encode('utf-8')
  CLUB = "\u2663".encode('utf-8')

  DECK_LIST = { "2#{SPADE}" => 2, "2#{HEART}" => 2, "2#{DIAMOND}" => 2, "2#{CLUB}" => 2,
                "3#{SPADE}" => 3, "3#{HEART}" => 3, "3#{DIAMOND}" => 3, "3#{CLUB}" => 3,
                "4#{SPADE}" => 4, "4#{HEART}" => 4, "4#{DIAMOND}" => 4, "4#{CLUB}" => 4,
                "5#{SPADE}" => 5, "5#{HEART}" => 5, "5#{DIAMOND}" => 5, "5#{CLUB}" => 5,
                "6#{SPADE}" => 6, "6#{HEART}" => 6, "6#{DIAMOND}" => 6, "6#{CLUB}" => 6,
                "7#{SPADE}" => 7, "7#{HEART}" => 7, "7#{DIAMOND}" => 7, "7#{CLUB}" => 7,
                "8#{SPADE}" => 8, "8#{HEART}" => 8, "8#{DIAMOND}" => 8, "8#{CLUB}" => 8,
                "9#{SPADE}" => 9, "9#{HEART}" => 9, "9#{DIAMOND}" => 9, "9#{CLUB}" => 9,
                "10#{SPADE}" => 10, "10#{HEART}" => 10, "10#{DIAMOND}" => 10, "10#{CLUB}" => 10,
                "V#{SPADE}" => 10, "V#{HEART}" => 10, "V#{DIAMOND}" => 10, "V#{CLUB}" => 10,
                "Q#{SPADE}" => 10, "Q#{HEART}" => 10, "Q#{DIAMOND}" => 10, "Q#{CLUB}" => 10,
                "K#{SPADE}" => 10, "K#{HEART}" => 10, "K#{DIAMOND}" => 10, "K#{CLUB}" => 10,
                "A#{SPADE}" => [1, 11], "A#{HEART}" => [1, 11], "A#{DIAMOND}" => [1, 11], "A#{CLUB}" => [1, 11] }.freeze

  attr_reader :card_list

  def initialize
    @card_list = DECK_LIST.reduce([]) { |deck, card| deck << Card.new(card[0], card[1]) }
  end
end
