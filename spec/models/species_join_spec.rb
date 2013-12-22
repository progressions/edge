# == Schema Information
#
# Table name: species_joins
#
#  id             :integer          not null, primary key
#  species_id     :integer
#  species_skills :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe SpeciesJoin do
  before(:each) do
    Species.seed!
    Career.seed!

    @character = create(:character, species: create(:species, name: "Human"))
    expect(@character.species).to be_present
    @character.species_skills = "Charm"
    expect(@character.skill("Charm").rank).to eq(1)
  end

  it "resets points" do
    another_species = create(:species, name: "Twi'lek")
    @character.species = another_species
    @character.save
    @character.reload
    expect(@character.species_join).to be_present
  end
end
