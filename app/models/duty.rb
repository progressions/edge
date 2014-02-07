# == Schema Information
#
# Table name: duties
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Duty < ActiveRecord::Base
  include Sluggable

  has_many :character_duties
  has_many :characters, through: :character_duty
end
