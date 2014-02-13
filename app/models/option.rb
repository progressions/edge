# == Schema Information
#
# Table name: options
#
#  id                      :integer          not null, primary key
#  option_choice_id        :integer
#  key                     :string(255)
#  name                    :string(255)
#  description             :string(255)
#  starting_skill_training :boolean
#  skill_count             :integer
#  non_career              :boolean
#  created_at              :datetime
#  updated_at              :datetime
#

class Option < ActiveRecord::Base
  belongs_to :option_choice
end
