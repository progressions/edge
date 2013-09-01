require 'spec_helper'

describe Species do
  before(:each) do
    @character = FactoryGirl.create(:character)
    @species = Species.get("bothan", @character)
    expect(@character.skills.length).to eq(32)
    @species.generate
  end

  it "should set charateristics" do
    expect(@character.brawn).to eq(@species.characteristics[:brawn])
  end

  it "should reset skills" do
    expect(@character.skills.length).to eq(32)
  end
end
