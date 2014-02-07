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
  belongs_to :rank
  belongs_to :character, foreign_key: "parent_id"
  belongs_to :characteristic, foreign_key: "parent_id"
end
