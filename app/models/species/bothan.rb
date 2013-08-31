class Bothan < Species
  def characteristics
    {
      brawn: 1,
      agility: 2,
      intellect: 2,
      cunning: 3,
      willpower: 2,
      presence: 2
    }
  end

  def unused_xp
    100
  end

  def wound_threshold_modifier
    10
  end

  def strain_threshold_modifier
    11
  end
end

