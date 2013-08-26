# == Schema Information
#
# Table name: characters
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  brawn        :integer          default(0), not null
#  agility      :integer          default(0), not null
#  intellect    :integer          default(0), not null
#  cunning      :integer          default(0), not null
#  presence     :integer          default(0), not null
#  available_xp :integer
#  spent_xp     :integer
#  user_id      :integer
#

require 'spec_helper'

describe Character do
  pending "add some examples to (or delete) #{__FILE__}"
end
