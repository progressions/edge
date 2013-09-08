require 'spec_helper'

describe "character creation", js: true do
  before(:each) do
    Species.seed!
    Career.seed!

    Obligation.stub(:rand).and_return(0.49)
    @user = create(:user)
    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
    click_link "New Character"
  end

  it "creates a character with name, random obligation and species" do
    # Step 1: Determine Character Name
    fill_in "Name", with: "Odeko"
    click_button "Save and Continue"

    # Step 2: Determine Party Size
    expect(page).to have_content("Determine Party Size")
    select "5", from: "Party Size"
    click_button "Save and Continue"

    # Step 3: Determine Starting Obligation
    expect(page).to have_content("Determine Starting Obligation")
    expect(page).to have_content("Your character has been updated.")
    expect(page).to have_content("Because your party size is")
    expect(page).to have_content("5")
    click_link "Random Obligation"

    # Step 4: Confirm Obligation
    expect(page).to have_content("Confirm Obligation")
    expect(page).to have_content("Dutybound")
    click_link "Save and Continue"

    # Step 5: Select Character Species
    expect(page).to have_content("Select Character Species")
    expect(page).to have_content("Bothan")
    find("#twilek").click
    click_button "Save and Continue"

    # Step 6: Select Character Species' Skills
    expect(page).to have_content("Select Character's Species Skills")
    select "Deception", from: "Skill"
    click_button "Save and Continue"

    # Step 7: Select Character Career
    expect(page).to have_content("Select Character Career")
    expect(page).to have_content("Bounty Hunter")
    expect(page).to have_content("Explorer")
    find("#explorer").click
    click_button "Save and Continue"

    # Step 8: Select Career Skills
    expect(page).to have_content("Select Character's Career Skills")
    within ".optional_skill_0" do
      select "Astrogation", from: "Skill"
    end
    within ".optional_skill_1" do
      select "Cool", from: "Skill"
    end
    within ".optional_skill_2" do
      select "Piloting (Space)", from: "Skill"
    end
    within ".optional_skill_3" do
      select "Survival", from: "Skill"
    end
    click_button "Save and Continue"

    # Step 9: Select Character Specialization
    expect(page).to have_content("Select Character Specialization")
    find("#scout").click
    click_button "Save and Continue"

    # Show Character and verify changes
    visit "/characters/#{Character.last.id}"
    expect(page).to have_content("Deception")
    within "tr#deception" do
      expect(page).to have_content(1)
    end

    within "tr#astrogation .career" do
      expect(page).to have_content("yes")
    end
    within "tr#cool .career" do
      expect(page).to have_content("yes")
    end
    within "tr#pilotingspace .career" do
      expect(page).to have_content("yes")
    end
    within "tr#survival .career" do
      expect(page).to have_content("yes")
    end

    within "p.career" do
      expect(page).to have_content("Explorer")
    end
    within ".specializations" do
      expect(page).to have_content("Explorer - Scout")
    end
  end
end
