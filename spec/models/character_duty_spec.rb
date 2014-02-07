# == Schema Information
#
# Table name: character_duties
#
#  id           :integer          not null, primary key
#  character_id :integer
#  duty_id      :integer
#  size         :integer
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe CharacterDuty do
  pending "add some examples to (or delete) #{__FILE__}"
end
