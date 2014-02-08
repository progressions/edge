# == Schema Information
#
# Table name: careers
#
#  id            :integer          not null, primary key
#  key           :string(255)
#  name          :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  source        :string(255)
#  career_skills :string(255)
#

require 'spec_helper'

describe Career do
  pending "add some examples to (or delete) #{__FILE__}"
end
