# == Schema Information
#
# Table name: specializations
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  career_skills :string(255)
#  career_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Specialization do
  pending "add some examples to (or delete) #{__FILE__}"
end
