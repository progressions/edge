# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  amount     :integer
#  source     :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Rank < ActiveRecord::Base
  has_many :rankables
  has_many :characters, through: :rankables

  def self.by_obligation
    where(source: "obligation")
  end

  def self.by_duty
    where(source: "duty")
  end
end
