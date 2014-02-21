# == Schema Information
#
# Table name: character_talent_boxes
#
#  id            :integer          not null, primary key
#  character_id  :integer
#  talent_box_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class CharacterTalentBox < ActiveRecord::Base
  belongs_to :character
  belongs_to :talent_box
end
