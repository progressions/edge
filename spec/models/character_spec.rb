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
#  party_size       :integer
#  base_obligation  :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#  species_id       :integer
#  career_id        :integer
#

require 'spec_helper'

describe Character do
  before(:each) do
    Species.seed!
    @character = create(:character)
    @twilek = Species.where(name: "Twi'lek").first
    @bothan = Species.where(name: "Bothan").first
    @human = Species.where(name: "Human").first
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

  describe "with species" do
    it "sets characteristics" do
      @character.set_species("Bothan")
      expect(@character.brawn).to eq(1)
      expect(@character.agility).to eq(2)
      expect(@character.intellect).to eq(2)
      expect(@character.cunning).to eq(3)
      expect(@character.willpower).to eq(2)
      expect(@character.presence).to eq(2)
    end

    it "sets wound threshold" do
      @character.set_species("Trandoshan")
      expect(@character.wound_threshold).to eq(15)
    end

    it "sets strain threshold" do
      @character.set_species("Trandoshan")
      expect(@character.strain_threshold).to eq(11)
    end

    it "sets unused xp" do
      @character.set_species("Trandoshan")
      expect(@character.unused_xp).to eq(90)
    end

    it "resets skill ranks" do
      @character.add_rank_to_skill("Charm")
      @character.set_species("Human")
      @character.save
      expect(@character.reload.skills.sum(:rank)).to eq(0)
    end
  end

  describe "with career" do
    before(:each) do
      Career.seed!
    end

    it "sets career" do
      colonist = Career.where(name: "Colonist").first
      @character.set_career("Colonist")
      colonist.career_skills.each do |career_skill|
        expect(@character.skill(career_skill)).to be_career
      end
    end
  end

  describe "with optional skills" do
    it "sets optional skill" do
      @character.optional_skills = ["Charm"]
      expect(@character.skill("Charm").rank).to eq(1)
    end

    it "sets multiple optional skills" do
      @character.optional_skills = ["Charm", "Deception"]
      expect(@character.skill("Charm").rank).to eq(1)
      expect(@character.skill("Deception").rank).to eq(1)
    end
  end
end
