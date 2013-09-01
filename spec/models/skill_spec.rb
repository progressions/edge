# == Schema Information
#
# Table name: skills
#
#  id             :integer          not null, primary key
#  character_id   :integer
#  name           :string(255)
#  rank           :integer
#  career         :boolean
#  characteristic :string(255)
#  category       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Skill do
  before(:each) do
    @skill = FactoryGirl.build(:skill)
  end

  describe "ch" do
    it "abbreviates the skills's characteristic" do
      expect(@skill.ch).to eq("Cu")
    end
  end

  describe "career_yn?" do
    it "shows no" do
      expect(@skill.career_yn?).to eq("no")
    end
  end
end
