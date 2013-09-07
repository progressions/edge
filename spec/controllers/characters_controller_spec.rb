require 'spec_helper'

describe CharactersController do
  before(:each) do
    @user = create(:user)
    @character = create(:character, user: @user)
    controller.stub(:current_user).and_return(@user)
  end

  describe "GET 'index'" do
    it "populates list of characters" do
      get :index
      expect(assigns(:characters)).to eq([@character])
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      expect(response).to redirect_to(character_build_url(:name, character_id: Character.last.id))
    end
  end

  describe "GET 'show'" do
    it "assigns @character" do
      get :show, id: @character.id
      expect(assigns(:character)).to eq(@character)
    end

    it "returns http success" do
      get :show, id: @character.id
      expect(response).to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to characters url" do
      delete :destroy, id: @character.id
      expect(response).to redirect_to(characters_url)
    end

    it "deletes the character" do
      expect {
        delete :destroy, id: @character.id
      }.to change(Character, :count).by(-1)
    end
  end
end
