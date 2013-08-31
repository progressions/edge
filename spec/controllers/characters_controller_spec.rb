require 'spec_helper'

describe CharactersController do
  before(:each) do
    @user = User.create(email: "test@test.com", password: "password", password_confirmation: "password")
    controller.stub!(:current_user).and_return(@user)
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      post 'create', character: {
        name: "Fred"
      }
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      @character = @user.characters.build(name: "Fred")
      get 'show', id: @character.id
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    pending
    it "returns http success" do
      response.should be_success
    end
  end

end
