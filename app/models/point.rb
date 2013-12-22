# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  skill_id   :integer
#  source     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Point < ActiveRecord::Base
  belongs_to :skill

  validates :skill_id, presence: true

  after_create :update_skill
  after_destroy :update_skill

  def update_skill
    skill.update_rank
  end
end
