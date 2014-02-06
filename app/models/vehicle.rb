# == Schema Information
#
# Table name: vehicles
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Vehicle < ActiveRecord::Base
  has_many :categorizables, foreign_key: "parent_id", dependent: :destroy
  has_many :categories, through: :categorizables
end
