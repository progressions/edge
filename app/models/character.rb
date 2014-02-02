# == Schema Information
#
# Table name: characters
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  player_name :string(255)
#

class Character < ActiveRecord::Base
  belongs_to :user

  def self.from_xml(xml)
    hash = Hash.from_xml(xml)
    character_params = {}
    character_params[:name] = hash["Character"]["Description"]["CharName"]
    character_params[:player_name] = hash["Character"]["Description"]["PlayerName"]

    create(character_params)
  end
end
