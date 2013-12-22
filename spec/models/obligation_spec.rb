# == Schema Information
#
# Table name: obligations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  amount       :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Obligation do
  before(:each) do
    Species.seed!
    Career.seed!
  end

  it "gets a random obligation for a value" do
    expect(Obligation.random_value(50)).to eq({:name=>"Dutybound", :description=>""})
  end

  it "returns random obligation values" do
    Obligation.stub(:rand).and_return(0.49)
    expect(Obligation.random_obligation_values).to eq({:name=>"Dutybound", :description=>""})
  end

  it "returns multiple values if index > 96" do
    Obligation.stub(:rand).and_return(0.96, 0.49, 0.74)
    expect(Obligation.random_obligation_values).to eq([{:name=>"Dutybound", :description=>""}, {:name=>"Oath", :description=>""}])
  end

  describe "randomize" do
    before(:each) do
      @character = create(:character)
    end

    it "returns random obligations" do
      Obligation.stub(:rand).and_return(0.49)
      expect(@character.obligations.randomize.first.name).to eq("Dutybound")
    end

    it "returns multiple obligations if index > 96" do
      Obligation.stub(:rand).and_return(0.96, 0.49, 0.74)
      expect(@character.obligations.randomize.length).to eq(2)
    end

    it "associates obligations with character" do
      Obligation.stub(:rand).and_return(0.49)
      expect(@character.obligations.randomize.first.character).to eq(@character)
    end

    it "associates multiple obligations with character" do
      Obligation.stub(:rand).and_return(0.96, 0.49, 0.74)
      @random_obligations = @character.obligations.randomize
      expect(@random_obligations.first.character).to eq(@character)
      expect(@random_obligations.second.character).to eq(@character)
    end
  end
end
