module DutiesHelper
  def duty_plus_five_xp_enabled?(character)
    character.duty_options.plus_five_xp? || character.duty_options.remaining_duty >= 5
  end

  def duty_plus_ten_xp_enabled?(character)
    character.duty_options.plus_ten_xp? || character.duty_options.remaining_duty >= 10
  end

  def duty_plus_thousand_credits_enabled?(character)
    character.duty_options.plus_thousand_credits? || character.duty_options.remaining_duty >= 5
  end

  def duty_plus_two_thousand_five_hundred_credits_enabled?(character)
    character.duty_options.plus_two_thousand_five_hundred_credits? || character.duty_options.remaining_duty >= 10
  end
end
