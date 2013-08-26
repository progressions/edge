# == Schema Information
#
# Table name: obligations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  amount       :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Obligation do
  pending "add some examples to (or delete) #{__FILE__}"
end
