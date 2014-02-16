# == Schema Information
#
# Table name: option_skill_modifiers
#
#  id         :integer          not null, primary key
#  option_id  :integer
#  key        :string(255)
#  rank_start :integer
#  rank_limit :integer
#  created_at :datetime
#  updated_at :datetime
#

class OptionSkillModifier < ActiveRecord::Base
  belongs_to :option
end
