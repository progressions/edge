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
  belongs_to :character
  belongs_to :talent
end
