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

  validates :species_id, presence: true

  serialize :species_skills, Array

  before_destroy :reset_points
  before_update :reset_points

  def reset_points
    if character.present?
      character.points.where(source: species.name).destroy_all
    end
  end
end
