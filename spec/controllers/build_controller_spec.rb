require 'spec_helper'

describe BuildController do
  before(:each) do
    Species.seed!
    Career.seed!

    @species = Species.where(name: "Human").first

    @user = create(:user)
    @character = create(:character, user: @user, species: @species)
    controller.stub(:current_user).and_return(@user)
  end

  describe "with new character" do
    it "creates character" do
      get :show, {
        id: "start",
        character_id: "new"
      }
      expect(assigns(:character)).to eq(Character.last)
    end

    it "redirects to name" do
      get :show, {
        id: "start",
        character_id: "new"
      }
      expect(response).to redirect_to(character_build_url(:name, character_id: Character.last.id))
    end
  end

  describe "name step" do
    it "assigns character" do
      get :show, {
        id: "name",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders name" do
      get :show, {
        id: "name",
        character_id: @character.id
      }
      expect(response).to render_template("build/name")
    end

    it "assigns name" do
      put :update, {
        id: "name",
        character_id: @character.id,
        character: {
          name: "Odeko"
        }
      }
      expect(@character.reload.name).to eq("Odeko")
    end

    it "sets flash message" do
      put :update, {
        id: "name",
        character_id: @character.id,
        character: {
          name: "Odeko"
        }
      }
      expect(flash[:notice]).to eq("Your character has been updated.")
    end

    it "redirects to party size" do
      put :update, {
        id: "name",
        character_id: @character.id,
        character: {
          name: "Odeko"
        }
      }
      expect(response).to redirect_to(character_build_url(:party_size, character_id: @character.id))
    end
  end

  describe "party size step" do
    it "assigns character" do
      get :show, {
        id: "party_size",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders party_size" do
      get :show, {
        id: "party_size",
        character_id: @character.id
      }
      expect(response).to render_template("build/party_size")
    end

    it "assigns party size" do
      put :update, {
        id: "party_size",
        character_id: @character.id,
        character: {
          party_size: 4
        }
      }
      expect(@character.reload.party_size).to eq(4)
    end

    it "redirects to obligation" do
      put :update, {
        id: "party_size",
        character_id: @character.id,
        character: {
          party_size: 4
        }
      }
      expect(response).to redirect_to(character_build_url(:obligation, character_id: @character.id))
    end
  end

  describe "obligation step" do
    before(:each) do
      @obligations_attributes = {
        "0" => {
          "_destroy" => false,
          "amount" => 10,
          "name" => "Obsession",
          "description" => "Obsessed with finding the greatest cheese in the galaxy."
        }
      }
    end

    it "assigns character" do
      get :show, {
        id: "obligation",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders obligation" do
      get :show, {
        id: "obligation",
        character_id: @character.id
      }
      expect(response).to render_template("build/obligation")
    end

    it "assigns obligation" do
      expect(@character.obligations).to be_empty
      put :update, {
        id: "obligation",
        character_id: @character.id,
        character: {
          obligations_attributes: @obligations_attributes
        }
      }
      expect(@character.reload.obligations.first.name).to eq("Obsession")
    end

    it "redirects to confirm_obligation" do
      put :update, {
        id: "obligation",
        character_id: @character.id,
        character: {
          obligations_attributes: @obligations_attributes
        }
      }
      expect(response).to redirect_to(character_build_url(:confirm_obligation, character_id: @character.id))
    end
  end

  describe "confirm obligation step" do
    it "assigns character" do
      get :show, {
        id: "confirm_obligation",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders confirm_obligation" do
      get :show, {
        id: "confirm_obligation",
        character_id: @character.id
      }
      expect(response).to render_template("build/confirm_obligation")
    end

    it "assigns random obligation if empty" do
      expect(@character.reload.obligations).to be_empty
      get :show, {
        id: "confirm_obligation",
        character_id: @character.id
      }
      expect(@character.reload.obligations).not_to be_empty
    end
  end
end
