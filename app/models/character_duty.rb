# == Schema Information
#
# Table name: character_duties
#
#  id           :integer          not null, primary key
#  character_id :integer
#  duty_id      :integer
#  size         :integer
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

class CharacterDuty < ActiveRecord::Base
  belongs_to :character
  belongs_to :duty
end
