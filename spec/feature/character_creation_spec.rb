require 'spec_helper'

describe "character creation", js: true do
  before(:each) do
    seed_species
  end

  it "creates a character with name, random obligation and species" do
    Obligation.stub(:rand).and_return(0.49)
    @user = create(:user)
    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
    click_link "New Character"
    fill_in "Name", with: "Odeko"
    click_button "Save and Continue"
    expect(page).to have_content("Obligations")
    select "5", from: "Party Size"
    click_button "Save and Continue"
    expect(page).to have_content("Your character has been updated.")
    expect(page).to have_content("Because your party size is")
    expect(page).to have_content("5")
    click_link "Random Obligation"
    expect(page).to have_content("Dutybound")
    click_link "Save and Continue"
    expect(page).to have_content("Bothan")
    find("#twilek").click
    click_button "Save and Continue"
    select "Deception", from: "Skill"
    click_button "Save and Continue"
    expect(page).to have_content("Deception")
    within "tr#deception" do
      expect(page).to have_content(1)
    end
  end
end
