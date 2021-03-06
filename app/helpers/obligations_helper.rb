module ObligationsHelper
  def obligation_plus_five_xp_enabled?(character)
    character.obligation_options.plus_five_xp? || character.obligation_options.remaining_obligation >= 5
  end

  def obligation_plus_ten_xp_enabled?(character)
    character.obligation_options.plus_ten_xp? || character.obligation_options.remaining_obligation >= 10
  end

  def obligation_plus_thousand_credits_enabled?(character)
    character.obligation_options.plus_thousand_credits? || character.obligation_options.remaining_obligation >= 5
  end

  def obligation_plus_two_thousand_five_hundred_credits_enabled?(character)
    character.obligation_options.plus_two_thousand_five_hundred_credits? || character.obligation_options.remaining_obligation >= 10
  end
end
