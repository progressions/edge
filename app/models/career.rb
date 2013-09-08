# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  career_skills :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Career < ActiveRecord::Base
  has_many :characters
  has_many :specializations

  serialize :career_skills, Array
  serialize :specializations, Array

  def self.seed!
    CAREERS.values.each do |attributes|
      attributes = attributes.dup

      specializations = Array(attributes.delete("specializations"))
      career = Career.where(name: attributes["name"]).first || Career.create(attributes)

      specializations.each do |spec_attributes|
        spec = career.specializations.where(name: spec_attributes["name"]).first ||
          career.specializations.create(spec_attributes)
      end
    end
  end
end
