require 'spec_helper'

describe "login" do
  before(:each) do
    @user = create(:user)
  end

  it "logs the user in with valid credentials" do
    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
    expect(page).to have_content("Logged in!")
    expect(page).to have_content(@user.email)
  end

  it "creates a character" do
    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
    expect(page).to have_content("Logged in!")
    expect(page).to have_content(@user.email)
    click_link "New Character"
    fill_in "Name", with: "Odeko"
    click_button "Save and Continue"
    expect(page).to have_content("Odeko")
    click_link "Species"
  end

  it "doesn't log in with invalid credentials" do
    visit "/login"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password + "not"
    click_button "Log in"
    expect(page).to have_content("Email or password was invalid.")
  end
end
