# == Schema Information
#
# Table name: backgrounds
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  source      :string(255)
#

require 'spec_helper'

describe Background do
  pending "add some examples to (or delete) #{__FILE__}"
end
