# == Schema Information
#
# Table name: careers
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  source      :string(255)
#  skill_keys  :string(255)
#

class Career < ActiveRecord::Base
  include Sourced
  include Sluggable

  include CareerSkillKeys

  has_many :character_careers
  has_many :character, through: :character_careers

  has_many :specializations

  def specializations_from_xml=(values)
    values.each do |value|
      specialization = Specialization.lookup(value)
      unless specializations.include?(specialization)
        specializations << specialization
      end
    end
    save
  end
end
