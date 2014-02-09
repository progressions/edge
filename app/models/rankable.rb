# == Schema Information
#
# Table name: rankables
#
#  id         :integer          not null, primary key
#  rank_id    :integer
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Rankable < ActiveRecord::Base
  belongs_to :rank, dependent: :destroy
  belongs_to :character, foreign_key: "parent_id", dependent: :destroy
  belongs_to :characteristic, foreign_key: "parent_id", dependent: :destroy
  belongs_to :experience, foreign_key: "parent_id",  dependent: :destroy
end
