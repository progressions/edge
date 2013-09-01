require 'spec_helper'

describe CharactersController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @character = FactoryGirl.create(:character, user: @user)
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
      expect(response).to be_success
    end
  end

  describe "GET 'create'" do
    it "redirects to character url" do
      post :create, character: FactoryGirl.attributes_for(:character)
      expect(response).to redirect_to(base_obligation_url(Character.last.id))
    end

    it "creates a new character" do
      expect {
        post :create, character: FactoryGirl.attributes_for(:character)
      }.to change(Character, :count).by(1)
    end
  end

  describe "GET 'edit'" do
    it "assigns @character" do
      get :edit, id: @character.id
      expect(assigns(:character)).to eq(@character)
    end

    it "returns http success" do
      get :edit, id: @character.id
      expect(response).to be_success
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

  describe "GET 'update'" do
    context "with new attributes" do
      it "locates the requested character" do
        put :update, id: @character.id,
          character: FactoryGirl.attributes_for(:character, name: "Odeko")
        expect(assigns(:character)).to eq(@character)
      end

      it "changes the character's attributes" do
        put :update, id: @character.id,
          character: FactoryGirl.attributes_for(:character, name: "Odeko")

        @character.reload
        expect(@character.name).to eq("Odeko")
      end

      it "redirects to thing" do
        put :update, id: @character.id,
          character: FactoryGirl.attributes_for(:character, name: "Odeko")

        expect(response).to redirect_to(character_obligations_url(@character))
      end
    end

    context "with random obligation" do
      before(:each) do
        @obligation = FactoryGirl.build(:obligation, character: @character)
        Obligation.stub(:randomize).and_return([@obligation])
      end

      it "redirects to obligations" do
        put :update, id: @character.id, commit: "Random Obligation"
        expect(response).to redirect_to(character_obligations_url(@character))
      end

      it "builds random obligation" do
        put :update, id: @character.id, commit: "Random Obligation"
        expect(assigns(:character).obligations).to eq([@obligation])
      end
    end
  end
end
