# == Schema Information
#
# Table name: categorizables
#
#  id          :integer          not null, primary key
#  category_id :integer
#  parent_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Categorizable < ActiveRecord::Base
  belongs_to :category
  belongs_to :weapon, foreign_key: "parent_id"
  belongs_to :vehicle, foreign_key: "parent_id"
end
