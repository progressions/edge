class Twilek < Species
  def characteristics
    {
      brawn: 1,
      agility: 2,
      intellect: 2,
      cunning: 2,
      willpower: 2,
      presence: 3
    }
  end

  def unused_xp
    100
  end

  def strain_threshold_modifier
    11
  end
end
