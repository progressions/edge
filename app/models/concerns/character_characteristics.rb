module CharacterCharacteristics
  extend ActiveSupport::Concern

  included do
    CHARACTERISTICS = [:brawn, :agility, :intellect, :cunning, :willpower, :presence]
  end

  def default_characteristics
    CHARACTERISTICS.each do |ch|
      default_characteristic(ch)
    end
  end

  def default_characteristic(ch)
    char = send(ch) || send("build_#{ch}")
    char.set_species_ranks(species.send(ch))
    char.save
  end

  def on_species_change
    self.character_species.character_options.delete_all
    self.species.option_choices.each do |choice|
      choice.options.each do |option|
        self.species_option = option.id
      end
    end
    ranks = self.characteristics.map(&:species_ranks).flatten
    ranks.each(&:destroy)

    default_characteristics
  end

  def on_career_change
    ranks = self.character_skills.map(&:career_ranks).flatten
    ranks.each(&:destroy)
  end

  def characteristic_amounts
    results = {}
    CHARACTERISTICS.each do |ch|
      results[ch] = send(ch).total_amount
    end
    results
  end
end
