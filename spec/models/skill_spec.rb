# == Schema Information
#
# Table name: skills
#
#  id             :integer          not null, primary key
#  character_id   :integer
#  name           :string(255)
#  rank           :integer
#  career         :boolean
#  species        :boolean
#  characteristic :string(255)
#  category       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Skill do
  before(:each) do
    @skill = build(:skill)
    @career = double('career', career_skills: ["Astrogation", "Charm"])
    @specializations = double('specializations', pluck: ["Skulduggery", "Charm"])
    @character = double('character', career: @career, specializations: @specializations)
    @skill.stub(:character).and_return(@character)
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

  describe "career?" do
    it "returns false if it's not listed in any career skills" do
      @skill.name = "Deception"
      expect(@skill.career?).to be_false
    end

    it "returns true if skill is listed in career's career skills" do
      @skill.name = "Astrogation"
      expect(@skill.career?).to be_true
    end

    it "returns true if skill is listed in a specialization's career skills" do
      @skill.name = "Skulduggery"
      expect(@skill.career?).to be_true
    end

    it "works if character has no career" do
      @character.stub(:career).and_return(nil)
      @skill.name = "Skulduggery"
      expect(@skill.career?).to be_true
    end

    it "works if character has no specializations" do
      @specializations.stub(:pluck).and_return([])
      @skill.name = "Skulduggery"
      expect(@skill.career?).to be_false
    end

    it "returns false if skill has no character" do
      @skill.character = nil
      expect(@skill.career?).to be_false
    end
  end
end
