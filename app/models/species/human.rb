class Human < Species
  def characteristics
    {
      brawn: 2,
      agility: 2,
      intellect: 2,
      cunning: 2,
      willpower: 2,
      presence: 2
    }
  end

  def unused_xp
    110
  end

  def optional_skills
    character.skills
  end
end
