# == Schema Information
#
# Table name: obligations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  amount       :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Obligation < ActiveRecord::Base
  belongs_to :character
end
