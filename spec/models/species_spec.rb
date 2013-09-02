require 'spec_helper'

describe Species do
  before(:each) do
    @character = create(:character)
  end

  describe "class methods" do
    it "returns all species" do
      expect(Species.all.length).to eq(8)
    end

    it "gets species class" do
      expect(Species.get("twilek").class).to eq(Twilek)
    end

    it "passes character" do
      @species = Species.get("twilek", @character)
      expect(@species.character).to eq(@character)
    end
  end

  describe "instance methods" do
    before(:each) do
      @species = Species.get("bothan", @character)
      @species.generate
    end

    it "sets characteristics" do
      expect(@character.brawn).to eq(@species.characteristics[:brawn])
    end

    it "sets unused xp" do
      expect(@character.unused_xp).to eq(@species.unused_xp)
    end

    it "resets used xp" do
      expect(@character.used_xp).to eq(0)
    end

    it "sets wound threshold" do
      expect(@character.wound_threshold).to eq(@species.wound_threshold)
    end

    it "sets strain threshold" do
      expect(@character.strain_threshold).to eq(@species.strain_threshold)
    end

    it "resets skills" do
      expect(@character.skills.sum(:rank)).to eq(1)
    end

    it "sets starting skills" do
      expect(@character.skill("Streetwise").rank).to eq(1)
    end
  end
end
