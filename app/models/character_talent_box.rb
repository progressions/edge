class CharacterTalentBox < ActiveRecord::Base
  belongs_to :character
  belongs_to :talent_box
end
