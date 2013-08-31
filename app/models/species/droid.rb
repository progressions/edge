class Droid < Species
  def characteristics
    {
      brawn: 1,
      agility: 1,
      intellect: 1,
      cunning: 1,
      willpower: 1,
      presence: 1
    }
  end

  def unused_xp
    175
  end
end
