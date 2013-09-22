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

  describe "species step" do
    before(:each) do
      @character.update_attributes(species_id: nil)
      @species = Species.where(name: "Twi'lek").first
    end

    it "assigns character" do
      get :show, {
        id: "species",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders species" do
      get :show, {
        id: "species",
        character_id: @character.id
      }
      expect(response).to render_template("build/species")
    end

    it "assigns species" do
      put :update, {
        id: "species",
        character_id: @character.id,
        character: {
          species_id: @species.id
        }
      }
      expect(@character.reload.species).to eq(@species)
    end

    it "redirects to species attributes step" do
      put :update, {
        id: "species",
        character_id: @character.id,
        character: {
          species_id: @species.id
        }
      }
      expect(response).to redirect_to(character_build_url(:species_attributes, character_id: @character.id))
    end
  end

  describe "species attributes step" do
    before(:each) do
      @species = Species.where(name: "Twi'lek").first
      @character.update_attributes(species_id: @species.id)
    end

    it "assigns character" do
      get :show, {
        id: "species_attributes",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "assigns species attributes" do
      get :show, {
        id: "species_attributes",
        character_id: @character.id
      }
      expect(@character.reload.brawn).to eq(@species.brawn)
      expect(@character.reload.agility).to eq(@species.agility)
      expect(@character.reload.intellect).to eq(@species.intellect)
      expect(@character.reload.cunning).to eq(@species.cunning)
      expect(@character.reload.willpower).to eq(@species.willpower)
      expect(@character.reload.presence).to eq(@species.presence)
    end

    it "redirects to species skills step" do
      get :show, {
        id: "species_attributes",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:species_skills, character_id: @character.id))
    end
  end

  describe "species skills step" do
    before(:each) do
      @species = Species.where(name: "Human").first
    end

    it "assigns character" do
      get :show, {
        id: "species_skills",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "redirects to species if they don't have one" do
      @character.update_attributes(species_id: nil)
      get :show, {
        id: "species_skills",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:species, character_id: @character.id))
    end

    it "renders species_skills" do
      get :show, {
        id: "species_skills",
        character_id: @character.id
      }
      expect(response).to render_template("build/species_skills")
    end

    it "assigns species skills" do
      put :update, {
        id: "species_skills",
        character_id: @character.id,
        character: {
          optional_skills: ["Astrogation", "Charm"]
        }
      }
      expect(@character.skill("Astrogation").rank).to eq(1)
      expect(@character.skill("Charm").rank).to eq(1)
    end

    context "when skills aren't unique" do
      it "doesn't update skills" do
        put :update, {
          id: "species_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(@character.skill("Astrogation").rank).to eq(0)
      end

      it "doesn't advance" do
        put :update, {
          id: "species_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(response).to render_template("build/species_skills")
      end

      it "sets flash message" do
        put :update, {
          id: "species_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(flash[:error]).to eq("There was an error updating your character.")
      end
    end

    it "redirects to career step" do
        put :update, {
          id: "species_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Charm"]
          }
        }
      expect(response).to redirect_to(character_build_url(:career, character_id: @character.id))
    end
  end
end
