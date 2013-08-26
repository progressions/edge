# == Schema Information
#
# Table name: characters
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  brawn       :integer          default(0), not null
#  agility     :integer          default(0), not null
#  intellect   :integer          default(0), not null
#  cunning     :integer          default(0), not null
#  presence    :integer          default(0), not null
#  unused_xp   :integer          default(0), not null
#  used_xp     :integer          default(0), not null
#

require 'spec_helper'

describe Character do
  pending "add some examples to (or delete) #{__FILE__}"
end
