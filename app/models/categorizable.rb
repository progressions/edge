# == Schema Information
#
# Table name: categorizables
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  categorizable_type :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Categorizable < ActiveRecord::Base
  belongs_to :category
  belongs_to :categorizable, polymorphic: true
end
