# == Schema Information
#
# Table name: experience_ranks
#
#  id           :integer          not null, primary key
#  character_id :integer
#  amount       :integer
#  source       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class ExperienceRank < ActiveRecord::Base
  SOURCES = [:starting, :species, :career, :talent, :obligation, :duty, :attachment, :item, :purchased, :character]

  belongs_to :character

  def self.by_obligation
    where(source: "obligation")
  end
end
