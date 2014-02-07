# == Schema Information
#
# Table name: obligations
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Obligation < ActiveRecord::Base
  include Sourced
  include Sluggable

  has_many :character_obligations
  has_many :characters, through: :character_obligation
end
