# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :categorizables
  has_many :weapons, through: :categorizables
  has_many :vehicles, through: :categorizables
end
