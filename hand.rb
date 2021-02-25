# frozen_string_literal: true

class Hand
  attr_accessor :cards, :total_score

  def initialize
    @cards = []
    @total_score = 0
  end

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
