class Rank < ActiveRecord::Base
  has_many :rankables
  has_many :characters, through: :rankables
end
