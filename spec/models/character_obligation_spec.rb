# == Schema Information
#
# Table name: character_obligations
#
#  id            :integer          not null, primary key
#  character_id  :integer
#  obligation_id :integer
#  size          :integer
#  created_at    :datetime
#  updated_at    :datetime
#  notes         :text
#

require 'spec_helper'

describe CharacterObligation do
  pending "add some examples to (or delete) #{__FILE__}"
end
