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

    description_hash = hash["Character"]["Description"]
    character_params[:name] = description_hash["CharName"]
    character_params[:player_name] = description_hash["PlayerName"]
    character_params[:gender] = description_hash["Gender"]
    character_params[:age] = description_hash["Age"]
    character_params[:height] = description_hash["Height"]
    character_params[:build] = description_hash["Build"]
    character_params[:hair] = description_hash["Hair"]
    character_params[:eyes] = description_hash["Eyes"]
    character_params[:notable_features] = description_hash["OtherFeatures"]

    create(character_params)
  end
end
