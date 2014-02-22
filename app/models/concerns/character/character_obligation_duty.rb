module CharacterObligationDuty
  extend ActiveSupport::Concern

  def total_obligation
    obligations.sum(:size).to_i
  end

  def total_duty
    duties.sum(:size).to_i
  end

  def update_obligation_credits
    return unless obligation_options.present?

    amount = self.credits.to_i

    if obligation_options.changes["plus_thousand_credits"] == [false, true]
      amount += 1000
    elsif obligation_options.changes["plus_thousand_credits"] == [true, false]
      amount -= 1000
    end

    if obligation_options.changes["plus_two_thousand_five_hundred_credits"] == [false, true]
      amount += 2500
    elsif obligation_options.changes["plus_two_thousand_five_hundred_credits"] == [true, false]
      amount -= 2500
    end

    self.credits = amount
  end

  def update_obligation_xp
    return unless obligation_options.present?

    amount = 0
    if obligation_options.plus_five_xp
      amount += 5
    end
    if obligation_options.plus_ten_xp
      amount += 10
    end
    # obligation_rank.update_attribute(:amount, amount)
  end

  def update_duty_credits
    return unless duty_options.present?

    amount = self.credits.to_i

    if duty_options.changes["plus_thousand_credits"] == [false, true]
      amount += 1000
    elsif duty_options.changes["plus_thousand_credits"] == [true, false]
      amount -= 1000
    end

    if duty_options.changes["plus_two_thousand_five_hundred_credits"] == [false, true]
      amount += 2500
    elsif duty_options.changes["plus_two_thousand_five_hundred_credits"] == [true, false]
      amount -= 2500
    end

    self.credits = amount
  end

  def update_duty_xp
    return unless duty_options.present?

    amount = 0
    if duty_options.plus_five_xp
      amount += 5
    end
    if duty_options.plus_ten_xp
      amount += 10
    end
    # duty_rank.update_attribute(:amount, amount)
  end
end
