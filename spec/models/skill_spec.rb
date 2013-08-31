# == Schema Information
#
# Table name: skills
#
#  id             :integer          not null, primary key
#  character_id   :integer
#  name           :string(255)
#  rank           :integer
#  career         :boolean
#  characteristic :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Skill do
  pending "add some examples to (or delete) #{__FILE__}"
end
