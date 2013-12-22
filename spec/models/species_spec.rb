# == Schema Information
#
# Table name: species
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  brawn                     :integer
#  agility                   :integer
#  intellect                 :integer
#  cunning                   :integer
#  willpower                 :integer
#  presence                  :integer
#  base_xp                   :integer
#  wound_threshold_modifier  :integer
#  strain_threshold_modifier :integer
#  optional_skills_count     :integer
#  starting_skills           :string(255)
#  optional_skills           :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#

require 'spec_helper'

describe Species do
  describe "class methods" do
    it "seeds 8 species" do
      Species.seed!
      expect(Species.count).to eq(8)
    end
  end
end
