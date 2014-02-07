# == Schema Information
#
# Table name: characteristics
#
#  id           :integer          not null, primary key
#  key          :string(255)
#  name         :string(255)
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Characteristic < ActiveRecord::Base
  belongs_to :character

  has_many :rankables, foreign_key: "parent_id", dependent: :destroy
  has_many :ranks, through: :rankables
end
