module Character::CalculatingExperience
  extend ActiveSupport::Concern

  def starting_experience
    self.species.try(:starting_xp).to_i + obligation_experience.to_i
  end

  def obligation_experience
    result = 0
    result += 5 if self.obligation_options.try(:plus_five_xp)
    result += 10 if self.obligation_options.try(:plus_ten_xp)

    result
  end

  def total_experience
    starting_experience + used_experience.to_i
  end

  def earned_experience
    0
  end

  def earned_experience=(amount)
  end

  def used_experience
    self.experience.try(:spent_experience).to_i
  end

  def unused_experience
    starting_experience.to_i - used_experience
  end
end
