class Gand < Species
  def characteristics
    {
      brawn: 2,
      agility: 2,
      intellect: 2,
      cunning: 2,
      willpower: 3,
      presence: 1
    }
  end

  def unused_xp
    100
  end

  def starting_skills
    [
      {name: "Discipline", rank: 1}
    ]
  end
end
