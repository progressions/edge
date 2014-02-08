# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  char_key    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  skill_type  :string(255)
#

class Skill < ActiveRecord::Base
end
