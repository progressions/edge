# == Schema Information
#
# Table name: characters
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  brawn            :integer          default(0), not null
#  agility          :integer          default(0), not null
#  intellect        :integer          default(0), not null
#  cunning          :integer          default(0), not null
#  willpower        :integer          default(0), not null
#  presence         :integer          default(0), not null
#  unused_xp        :integer          default(0), not null
#  used_xp          :integer          default(0), not null
#  species          :string(255)
#  party_size       :integer
#  base_obligation  :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#

require 'spec_helper'

describe Character do
  before(:each) do
    @character = create(:character)
  end

  it "has a valid factory" do
    expect(@character).to be_valid
  end

  it "sets default skills" do
    @character.save
    expect(@character.skills.length).to eq(32)
  end

  it "sets base obligation" do
    @character.update_attributes(party_size: 2)
    @character.save
    expect(@character.base_obligation).to eq(20)
  end

  it "shows total obligation amount" do
    @character.obligations << build(:obligation, amount: 5)
    @character.obligations << build(:obligation, amount: 10)
    expect(@character.total_obligation_amount).to eq(15)
  end

  it "shows total xp" do
    @character.unused_xp = 50
    @character.used_xp = 75
    expect(@character.total_xp).to eq(125)
  end

  it "adds a rank to a skill" do
    @character.add_rank_to_skill("Cool")
    expect(@character.skills.where(name: "Cool").first.rank).to eq(1)
  end

  it "gets skill by name" do
    expect(@character.skill("Cool").name).to eq("Cool")
  end

  describe "with new species" do
    it "sets species attributes" do
      @character.update_attributes(species: "twilek")
      expect(@character.presence).to eq(3)
    end

    it "sets species skills" do
      @character.update_attributes(species: "rodian")
      expect(@character.skills.where(name: "Survival").first.rank).to eq(1)
    end

    it "sets species wound threshold" do
      @character.update_attributes(species: "trandoshan")
      expect(@character.wound_threshold).to eq(15)
    end

    it "sets species strain threshold" do
      @character.update_attributes(species: "trandoshan")
      expect(@character.strain_threshold).to eq(11)
    end
  end

  describe "with random obligations" do
    it "sets random obligations" do
      @obligation = build(:obligation, character: @character)
      Obligation.stub(:randomize).and_return([@obligation])

      @character.build_random_obligations!
      expect(@character.obligations).to eq([@obligation])
    end

    it "random obligations have base_obligation evenly divided" do
      @character.base_obligation = 20

      @first_obligation = build(:obligation, character: @character)
      @second_obligation = build(:obligation, character: @character)
      Obligation.stub(:randomize).and_return([@first_obligation, @second_obligation])

      @character.build_random_obligations!
      expect(@first_obligation.amount).to eq(10)
      expect(@second_obligation.amount).to eq(10)
    end
  end

  describe "with optional skills" do
    it "sets optional skill" do
      @character.optional_skills = ["Charm"].to_json
      expect(@character.skill("Charm").rank).to eq(1)
    end
  end
end
