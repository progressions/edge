class Rodian < Species
  def characteristics
    {
      brawn: 2,
      agility: 3,
      intellect: 2,
      cunning: 2,
      willpower: 1,
      presence: 2
    }
  end

  def unused_xp
    100
  end

  def starting_skills
    [
      {name: "Survival", rank: 1}
    ]
  end
end
