# == Schema Information
#
# Table name: character_options
#
#  id                   :integer          not null, primary key
#  character_species_id :integer
#  choice_key           :string(255)
#  option_key           :string(255)
#  skill_trainings      :text
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe CharacterOption do
  pending "add some examples to (or delete) #{__FILE__}"
end
