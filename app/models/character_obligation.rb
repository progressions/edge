class CharacterObligation < ActiveRecord::Base
  belongs_to :character
  belongs_to :obligation
end
