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
#  skill_keys  :string(255)
#

class Specialization < ActiveRecord::Base
  include Sourced
  include Sluggable
  include CareerSkillKeys

  has_many :character_specializations
  has_many :characters, through: :character_specialization
  has_many :talent_rows, dependent: :destroy

  def talent_rows_from_xml=(values)
    values = [values].flatten
    values.each do |new_values|
      new_values[:specialization_id] = self.id
      Loader.load_single(TalentRow, new_values)
    end
  end
end
