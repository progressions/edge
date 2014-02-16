# == Schema Information
#
# Table name: talents
#
#  id                   :integer          not null, primary key
#  key                  :string(255)
#  name                 :string(255)
#  description          :string(255)
#  ranked               :boolean
#  activation           :string(255)
#  additional_hp        :integer
#  source               :string(255)
#  talent_attributes    :text
#  damage               :text
#  choose_career_skills :text
#  jury_rigged          :boolean
#  skill_choice         :text
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Talent do
  pending "add some examples to (or delete) #{__FILE__}"
end
