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

require 'spec_helper'

describe CharacterSpecies do
  pending "add some examples to (or delete) #{__FILE__}"
end
