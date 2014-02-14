class AddChoiceKeyToCharacterSpecies < ActiveRecord::Migration
  def change
    add_column :character_species, :choice_key, :string
    add_column :character_species, :option_key, :string
    add_column :character_species, :skill_trainings, :text
  end
end
