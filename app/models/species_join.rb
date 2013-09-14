# == Schema Information
#
# Table name: species_joins
#
#  id             :integer          not null, primary key
#  species_id     :integer
#  species_skills :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class SpeciesJoin < ActiveRecord::Base
  belongs_to :species
  has_one :character

  serialize :species_skills, Array
end
