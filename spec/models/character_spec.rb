# == Schema Information
#
# Table name: characters
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :text
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  brawn           :integer          default(0), not null
#  agility         :integer          default(0), not null
#  intellect       :integer          default(0), not null
#  cunning         :integer          default(0), not null
#  willpower       :integer          default(0), not null
#  presence        :integer          default(0), not null
#  unused_xp       :integer          default(0), not null
#  used_xp         :integer          default(0), not null
#  species         :string(255)
#  party_size      :integer
#  base_obligation :integer
#

require 'spec_helper'

describe Character do
  before(:each) do
    @character = Character.new
  end

  it "sets base obligation" do
    @character.update_attributes(party_size: 2)
    @character.save
    expect(@character.base_obligation).to eq(20)
  end
end
