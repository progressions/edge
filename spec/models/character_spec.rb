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
#  player_name      :string(255)
#  gender           :string(255)
#  age              :string(255)
#  height           :string(255)
#  build            :string(255)
#  hair             :string(255)
#  eyes             :string(255)
#  notable_features :text
#  credits          :integer
#  used_experience  :integer
#

require 'spec_helper'

describe Character do
  before(:each) do
    Species.seed!
    Career.seed!

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
    expect(@character.skills.length).to eq(33)
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
    @character.add_rank_to_skill("Cool", "Thing")
    expect(@character.skills.where(name: "Cool").first.rank).to eq(1)
  end

  it "gets skill by name" do
    expect(@character.skill("Cool").name).to eq("Cool")
  end

  describe "career skills" do
    it "collects skills with names in career skills" do
      @skill = @character.skills.where(name: "Athletics").first
      expect(@character.career_skills).to include(@skill)
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
      @character.add_rank_to_skill("Charm", "Thing")
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

    it "applies career skills" do
      colonist = Career.where(name: "Colonist").first
      @character.career = colonist

      @character.apply_career
      colonist.career_skills.each do |career_skill|
        expect(@character.skill(career_skill)).to be_career
      end
    end
  end

  describe "with specializations" do
    before(:each) do
      Career.seed!
      @character = create(:character)
      @character.specializations = []
      @specialization = @character.career.specializations.first
      @character.specializations << @specialization
    end

    context "with one specialization" do
      it "sets specialization skills" do
        @character.apply_specializations
        @specialization.career_skills.each do |career_skill|
          expect(@character.skill(career_skill)).to be_career
        end
      end

      it "applies career skills" do
        @character.apply_specializations
        @specialization.career_skills.each do |career_skill|
          expect(@character.skill(career_skill)).to be_career
        end
      end
    end

    context "with multiple specializations" do
      it "can't add the same specialization twice" do
        @character.specializations << @specialization
        expect(@character).not_to be_valid
      end
    end
  end

  describe "when assigning career_skills" do
    it "adds 1 to career skill rank" do
      @character.career_skills = ["Charm"]
      expect(@character.skill("Charm").rank).to eq(1)
    end

    it "adds 1 to existing skill rank" do
      @character.add_rank_to_skill("Charm", "Thing", 1)
      @character.career_skills = ["Charm"]
      expect(@character.skill("Charm").rank).to eq(2)
    end

    it "sets career_join career_skills" do
      @character.career_skills = ["Charm"]
      expect(@character.career_join.career_skills).to eq(["Charm"])
    end
  end

  describe "with optional skills" do
    pending "changing this method to be more specific"
    it "sets optional skill" do
      @character.optional_skills = ["Charm"]
      expect(@character.skill("Charm").rank).to eq(1)
    end

    it "sets multiple optional skills" do
      @character.optional_skills = ["Charm", "Deception"]
      expect(@character.skill("Charm").rank).to eq(1)
      expect(@character.skill("Deception").rank).to eq(1)
    end

    it "is not valid if optional skills aren't unique" do
      @character.optional_skills = ["Charm", "Charm"]
      expect(@character).not_to be_valid
    end

    it "sets error if optional skills aren't unique" do
      @character.optional_skills = ["Charm", "Charm"]
      @character.valid?
      expect(@character.errors).not_to be_empty
    end

    it "doesn't set skills if optional skills aren't unique" do
      @character.optional_skills = ["Charm", "Charm"]
      expect(@character.skill("Charm").rank).to eq(0)
    end
  end

  describe "with species skills" do
    it "sets optional skill" do
      @character.species_skills = ["Deception"]
      expect(@character.skill("Deception").rank).to eq(1)
    end
  end

  describe "with specialization_id" do
    before(:each) do
      Career.seed!
      expect(Specialization.count).to eq(18)
      @specialization = Specialization.first
    end

    it "sets specialization one at a time" do
      @character.specializations = []
      @character.specialization_id = @specialization.id
      expect(@character.specializations).to include(@specialization)
    end
  end
end
