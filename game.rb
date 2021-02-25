# frozen_string_literal: true

class Game
  private

  attr_accessor :user, :dealer, :bank, :deck, :stop
  attr_reader :interface

  public

  WINING_SUM = 50
  TOTAL_BANK = 1000

  def initialize(user, dealer, interface)
    @bank = TOTAL_BANK
    @stop = false
    @dealer = dealer
    @user = user
    @interface = interface
  end

  def start
    interface.set_user_name(user)
    loop do
      interface.show_bank_status(bank, WINING_SUM)
      create_initial_data
      play_one_game
      break unless restart? && bank.positive?

      update_initial_data
    end
    interface.game_over
  end

  private

  def play_one_game
    loop do
      validate!
      break if stop

      interface.show_user_cards(user)
      interface.show_hidden_dealer_cards(dealer)
      perform_user_action
      break if stop

      perform_dealer_action
    end
  end

  def add_card_to_user
    card_index = rand(0..deck.card_list.size - 1)
    card = deck.card_list.delete_at(card_index)
    user.add_card(card)
  end

  def add_card_to_dealer
    card_index = rand(0..deck.card_list.size - 1)
    card = deck.card_list.delete_at(card_index)
    dealer.add_card(card)
  end

  def update_bank(winer)
    self.bank -= WINING_SUM
    case winer
    when user.name
      user.bank += WINING_SUM
    when dealer.name
      dealer.bank += WINING_SUM
    when 'Ничья!'
      user.bank += WINING_SUM / 2
      dealer.bank += WINING_SUM / 2
    end
    interface.show_updated_bank(user, dealer)
  end

  def create_initial_data
    @deck = Deck.new
    2.times do
      add_card_to_user
      add_card_to_dealer
    end
  end

  def perform_user_action
    action = interface.user_action_menu
    case action
    when 1
      raise CardQuantityError, interface.cards_error_message if user.hand.cards.size == 3

      add_card_to_user
    when 2
      interface.skip
    when 3
      end_game
    end
  rescue CardQuantityError => e
    interface.error(e)
    retry
  end

  def perform_dealer_action
    interface.dealer_action
    sleep 1
    if (dealer.hand.total_score <= 17) && (dealer.hand.cards.size < 3)
      add_card_to_dealer
    else
      interface.skip
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity

  def end_game
    sleep 1
    self.stop = true
    winer = if ((21 - user.hand.total_score) < (21 - dealer.hand.total_score)) && (user.hand.total_score <= 21)
              user.name
            elsif (dealer.hand.total_score <= 21) && (user.hand.total_score <= 21) && (user.hand.total_score == dealer.hand.total_score)
              'Ничья!'
            elsif dealer.hand.total_score <= 21
              dealer.name
            elsif user.hand.total_score <= 21
              user.name
            else
              'Все проиграли!'
            end
    interface.show_winner(winer)
    interface.show_user_cards(user)
    interface.show_open_dealer_cards(dealer)
    update_bank(winer)
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def update_initial_data
    user.hand.cards = []
    dealer.hand.cards = []
    user.hand.total_score = 0
    dealer.hand.total_score = 0
    self.stop = false
  end

  def restart?
    action = interface.restart
    case action
    when 1
      true
    when 2
      false
    end
  end

  def validate!
    end_game if (dealer.hand.cards.size == 3) && (user.hand.cards.size == 3)
  end
end
