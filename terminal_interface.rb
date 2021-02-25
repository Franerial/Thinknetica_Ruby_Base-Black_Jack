# frozen_string_literal: true

require_relative 'exeption_classes'

class TerminalInterface
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

  CARDS_ERROR_MESSAGE = 'Кол-во карт не может быть больше 3!'

  def cards_error_message
    CARDS_ERROR_MESSAGE
  end

  def show_bank_status(bank, win_sum)
    puts "Общий размер банка: #{bank}"
    puts "Текущий размер выйгрыша: #{win_sum}"
    puts
  end

  def show_user_cards(user)
    puts 'Текущие карты пользователя:'
    user.hand.cards.each_with_index { |card, index| puts "Карта #{index}: #{card.name}" }
    puts "Текущая сумма очков пользователя #{user.name}: #{user.hand.total_score}"
    puts
  end

  def show_hidden_dealer_cards(dealer)
    puts 'Текущие карты дилера:'
    dealer.hand.cards.each_with_index { |_card, index| puts "Карта #{index}: ***" }
    puts
  end

  def show_open_dealer_cards(dealer)
    puts 'Текущие карты дилера:'
    dealer.hand.cards.each_with_index { |card, index| puts "Карта #{index}: #{card.name}" }
    puts "Текущая сумма очков дилера: #{dealer.hand.total_score}"
    puts
  end

  # rubocop:disable Naming/AccessorMethodName

  def set_user_name(user)
    puts 'Пожалуйста, введите имя пользователя:'
    name = gets.chomp
    puts
    user.name = name
  rescue ValidationTypeError => e
    puts e.message
    puts 'Повторите попытку!'
    retry
  end

  # rubocop:enable Naming/AccessorMethodName

  def user_action_menu
    puts 'Пожалуйста, выберите действие:'
    puts USER_MENU
    gets.chomp.to_i
  end

  def skip
    puts 'Пропуск хода!'
    puts
  end

  def error(exeption_object)
    puts
    puts exeption_object.message
    puts 'Повторите попытку!'
    puts
  end

  def dealer_action
    puts
    puts 'Ход диллера...'
    puts
  end

  def show_winner(winer)
    puts
    puts "ПОБЕДИТЕЛЬ: #{winer}"
    puts
  end

  def game_over
    puts 'Игра завершена!'
  end

  def show_updated_bank(user, dealer)
    puts "Текущий банк пользователя #{user.name} : #{user.bank}"
    puts "Текущий банк дилера : #{dealer.bank}"
    puts
  end

  def restart
    puts RESTART_MENU
    puts 'Пожалуйста, выберите действие:'
    action = gets.chomp.to_i
    puts '*********************************************'
    puts
    action
  end
end
