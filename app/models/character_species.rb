# == Schema Information
#
# Table name: character_species
#
#  id              :integer          not null, primary key
#  character_id    :integer
#  species_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  choice_key      :string(255)
#  option_key      :string(255)
#  skill_trainings :text
#

class CharacterSpecies < ActiveRecord::Base
  belongs_to :character
  belongs_to :species
end
