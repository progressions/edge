# == Schema Information
#
# Table name: option_choices
#
#  id         :integer          not null, primary key
#  species_id :integer
#  key        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class OptionChoice < ActiveRecord::Base
end
