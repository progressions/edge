# == Schema Information
#
# Table name: specialization_joins
#
#  id                :integer          not null, primary key
#  character_id      :integer
#  specialization_id :integer
#  career_skills     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class SpecializationJoin < ActiveRecord::Base
  belongs_to :character
  belongs_to :specialization

  # validates_uniqueness_of :specialization, scope: :character
end
