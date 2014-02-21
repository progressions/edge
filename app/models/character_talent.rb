# == Schema Information
#
# Table name: character_talents
#
#  id           :integer          not null, primary key
#  character_id :integer
#  talent_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterTalent < ActiveRecord::Base
  include HasRanks

  belongs_to :character
  belongs_to :talent

  delegate :name, to: :talent

  def experience_cost
    5
  end
end
