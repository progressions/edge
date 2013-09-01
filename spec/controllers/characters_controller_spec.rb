require 'spec_helper'

describe CharactersController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @character = FactoryGirl.create(:character, user: @user)
    controller.stub(:current_user).and_return(@user)
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      post 'create', character: {
        name: "Fred"
      }
      expect(response).to be_redirect
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: @character.id
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @character.id
      expect(response).to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "returns http success" do
      delete 'destroy', id: @character.id
      expect(response).to redirect_to(characters_url)
    end
  end

  describe "GET 'update'" do
    context "with random obligation" do
      it "sets sets random obligation" do
        put :update, id: @character.id, commit: "Random Obligation"
        expect(response).to redirect_to(character_obligations_url(@character))
      end
    end
  end
end
