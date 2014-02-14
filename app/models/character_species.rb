# == Schema Information
#
# Table name: character_species
#
#  id           :integer          not null, primary key
#  character_id :integer
#  species_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterSpecies < ActiveRecord::Base
  belongs_to :character
  belongs_to :species
  has_many :character_options
end
