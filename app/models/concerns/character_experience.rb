module CharacterExperience
  extend ActiveSupport::Concern

  def starting_experience
    species.try(:starting_xp).to_i
  end

  def total_experience
    starting_experience + used_experience.to_i
  end

  def earned_experience_rank
  end

  def earned_experience
    0
  end

  def earned_experience=(amount)
  end

  def unused_experience
    total_experience.to_i - used_experience.to_i
  end

end
