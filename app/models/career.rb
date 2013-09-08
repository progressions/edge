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
      Rails.logger.info "Creating #{attributes['name']}"
      Rails.logger.info attributes.inspect

      specializations = Array(attributes.delete("specializations"))
      career = Career.where(name: attributes["name"]).first || Career.create(attributes)
      specializations.each do |specialization|
        Rails.logger.info "Creating #{specialization['name']}"
        Rails.logger.info specialization.inspect

        career.specializations.where(name: specialization["name"]).first || career.specializations.create(specialization)
      end
    end
  end
end
