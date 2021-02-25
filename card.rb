# frozen_string_literal: true

class Card
  SPADE = "\u2660".encode('utf-8')
  HEART = "\u2665".encode('utf-8')
  DIAMOND = "\u2666".encode('utf-8')
  CLUB = "\u2663".encode('utf-8')

  PICTURES = %w[V Q K A].freeze
  SUITS = [SPADE, HEART, DIAMOND, CLUB].freeze
  VALUES = (2..10).to_a.freeze
  attr_reader :name, :cost

  def initialize(name, cost)
    @name = name
    @cost = cost
  end
end
