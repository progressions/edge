# == Schema Information
#
# Table name: duties
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Duty do
  pending "add some examples to (or delete) #{__FILE__}"
end
