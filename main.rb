# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'validation'
require_relative 'exeption_classes'

class Interface
  private

  attr_accessor :user, :dealer, :deck, :bank, :stop

  public

  WINING_SUM = 50
  TOTAL_BANK = 1000

  USER_MENU = <<~HERE
    1. Добавить карту
    2. Пропустить ход
    3. Открыть карты и завершить игру
  HERE

  RESTART_MENU = <<~HERE
    Желайте ли вы продолжить игру?
    1. Да
    2. Нет
  HERE

  def initialize
    @bank = TOTAL_BANK
    @stop = false
    @dealer = Dealer.new
    create_user
  end

  def start
    loop do
      puts "Общий размер банка: #{bank}"
      puts "Текущий размер выйгрыша: #{WINING_SUM}"
      puts
      create_initial_data
      play_one_game
      break unless restart? && bank.positive?

      update_initial_data
    end
    puts 'Игра завершена!'
  end

  private

  def play_one_game
    loop do
      validate!
      break if stop

      show_user_cards
      show_hidden_dealer_cards
      perform_user_action
      break if stop

      perform_dealer_action
    end
  end

  def create_user
    puts 'Пожалуйста, введите имя пользователя:'
    name = gets.chomp
    @user = Player.new(name)
    puts
  rescue ValidationTypeError => e
    puts e.message
    puts 'Повторите попытку!'
    retry
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

  def show_user_cards
    puts 'Текущие карты пользователя:'
    user.cards.each_with_index { |card, index| puts "Карта #{index}: #{card.name}" }
    puts "Текущая сумма очков пользователя #{user.name}: #{user.total_score}"
    puts
  end

  def show_open_dealer_cards
    puts 'Текущие карты дилера:'
    dealer.cards.each_with_index { |card, index| puts "Карта #{index}: #{card.name}" }
    puts "Текущая сумма очков дилера: #{dealer.total_score}"
    puts
  end

  def show_hidden_dealer_cards
    puts 'Текущие карты дилера:'
    dealer.cards.each_with_index { |_card, index| puts "Карта #{index}: ***" }
    puts
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
    puts "Текущий банк пользователя #{user.name} : #{user.bank}"
    puts "Текущий банк дилера : #{dealer.bank}"
    puts
  end

  def create_initial_data
    @deck = Deck.new
    2.times do
      add_card_to_user
      add_card_to_dealer
    end
  end

  def perform_user_action
    puts 'Пожалуйста, выберите действие:'
    puts USER_MENU
    action = gets.chomp.to_i
    case action
    when 1
      raise CardQuantityError, 'Кол-во карт не может быть больше 3!' if user.cards.size == 3

      add_card_to_user
    when 2
      puts 'Пропуск хода!'
    when 3
      end_game
    end
  rescue CardQuantityError => e
    puts
    puts e.message
    puts 'Повторите попытку!'
    puts
    retry
  end

  def perform_dealer_action
    puts
    puts 'Ход диллера...'
    puts
    sleep 1
    if (dealer.total_score <= 17) && (dealer.cards.size < 3)
      add_card_to_dealer
    else
      puts 'Пропуск хода!'
      puts
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity

  def end_game
    sleep 1
    self.stop = true
    winer = if ((21 - user.total_score) < (21 - dealer.total_score)) && (user.total_score <= 21)
              user.name
            elsif (dealer.total_score <= 21) && (user.total_score <= 21) && (user.total_score == dealer.total_score)
              'Ничья!'
            elsif dealer.total_score <= 21
              dealer.name
            elsif user.total_score <= 21
              user.name
            else
              'Все проиграли!'
            end
    puts
    puts "ПОБЕДИТЕЛЬ: #{winer}"
    puts
    show_user_cards
    show_open_dealer_cards
    update_bank(winer)
  end

  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def update_initial_data
    user.cards = []
    dealer.cards = []
    user.total_score = 0
    dealer.total_score = 0
    self.stop = false
  end

  def restart?
    puts RESTART_MENU
    puts 'Пожалуйста, выберите действие:'
    action = gets.chomp.to_i
    puts '*********************************************'
    puts
    case action
    when 1
      true
    when 2
      false
    end
  end

  def validate!
    end_game if (dealer.cards.size == 3) && (user.cards.size == 3)
  end
end

game = Interface.new
game.start
