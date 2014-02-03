# == Schema Information
#
# Table name: character_obligations
#
#  id            :integer          not null, primary key
#  character_id  :integer
#  obligation_id :integer
#  size          :integer
#  created_at    :datetime
#  updated_at    :datetime
#  notes         :text
#

class CharacterObligation < ActiveRecord::Base
  belongs_to :character
  belongs_to :obligation
end
