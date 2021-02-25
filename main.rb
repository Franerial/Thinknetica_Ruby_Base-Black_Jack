# frozen_string_literal: true

require_relative 'deck'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'game'
require_relative 'terminal_interface'

class BlackJack
  attr_reader :game

  def initialize
    user = User.new
    dealer = Dealer.new
    interface = TerminalInterface.new
    @game = Game.new(user, dealer, interface)
  end

  def start_game
    game.start
  end
end

BlackJack.new.start_game
