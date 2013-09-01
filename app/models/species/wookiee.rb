class Wookiee < Species
  def characteristics
    {
      brawn: 3,
      agility: 2,
      intellect: 2,
      cunning: 2,
      willpower: 1,
      presence: 2
    }
  end

  def unused_xp
    90
  end

  def wound_threshold_modifier
    14
  end

  def strain_threshold_modifier
    8
  end

  def starting_skills
    [
      {name: "Brawl", rank: 1}
    ]
  end
end
