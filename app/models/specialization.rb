# == Schema Information
#
# Table name: specializations
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  universal   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  career_id   :integer
#

class Specialization < ActiveRecord::Base
  include Sourced
  include Sluggable

  has_many :character_specializations
  has_many :characters, through: :character_specialization
end
