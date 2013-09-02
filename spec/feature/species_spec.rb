require 'spec_helper'

describe "Species", js: true do
  before(:each) do
    @user = create(:user)
  end

  it "creates a character" do
    pending
    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
    click_link "New Character"
    fill_in "Name", with: "Odeko"
    click_button "Save and Continue"
    expect(page).to have_content("Odeko")
    click_link "Species"
    expect(page).to have_content("Twi'lek")
    find("#twilek").click
    within ".twilek" do
      select "Deception", from: "optional_skill_0"
      click_link "Save"
    end
  end
end
