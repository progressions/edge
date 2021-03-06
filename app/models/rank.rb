# == Schema Information
#
# Table name: ranks
#
#  id          :integer          not null, primary key
#  amount      :integer
#  source      :string(255)
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  parent_type :string(255)
#  parent_id   :integer
#

class Rank < ActiveRecord::Base
  def self.by_obligation
    where(source: "obligation")
  end

  def self.by_duty
    where(source: "duty")
  end

  def self.by_species
    where(source: "species")
  end
end
