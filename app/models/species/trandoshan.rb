class Trandoshan < Species
  def characteristics
    {
      brawn: 3,
      agility: 1,
      intellect: 2,
      cunning: 2,
      willpower: 2,
      presence: 2
    }
  end

  def unused_xp
    90
  end

  def wound_threshold_modifier
    12
  end

  def strain_threshold_modifier
    9
  end

  def starting_skills
    [
      {name: "Perception", rank: 1}
    ]
  end
end
