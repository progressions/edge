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

  describe "career step" do
    before(:each) do
      @career = Career.where(name: "Smuggler").first
    end

    it "assigns character" do
      get :show, {
        id: "career",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders career" do
      get :show, {
        id: "career",
        character_id: @character.id
      }
      expect(response).to render_template("build/career")
    end

    it "assigns career" do
      put :update, {
        id: "career",
        character_id: @character.id,
        character: {
          career_id: @career.id
        }
      }
      expect(@character.reload.career).to eq(@career)
    end

    it "redirects to species if they don't have one" do
      @character.update_attributes(species_id: nil)
      get :show, {
        id: "career",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:species, character_id: @character.id))
    end

    it "redirects to career skills step" do
      put :update, {
        id: "career",
        character_id: @character.id,
        character: {
          career_id: @career.id
        }
      }
      expect(response).to redirect_to(character_build_url(:career_skills, character_id: @character.id))
    end
  end

  describe "career skills step" do
    it "assigns character" do
      get :show, {
        id: "career_skills",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "redirects to species if they don't have one" do
      @character.update_attributes(species_id: nil)
      get :show, {
        id: "career_skills",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:species, character_id: @character.id))
    end

    it "redirects to career if they don't have one" do
      @character.update_attributes(career_id: nil)
      get :show, {
        id: "career_skills",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:career, character_id: @character.id))
    end

    it "renders career_skills" do
      get :show, {
        id: "career_skills",
        character_id: @character.id
      }
      expect(response).to render_template("build/career_skills")
    end

    it "sets career's career skills" do
      get :show, {
        id: "career_skills",
        character_id: @character.id
      }
      expect(@character.skills.career.count).to eq(8)
    end

    it "assigns ranks to chosen career skills" do
      put :update, {
        id: "career_skills",
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
          id: "career_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(@character.skill("Astrogation").rank).to eq(0)
      end

      it "doesn't advance" do
        put :update, {
          id: "career_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(response).to render_template("build/career_skills")
      end

      it "sets flash message" do
        put :update, {
          id: "career_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(flash[:error]).to eq("There was an error updating your character.")
      end
    end

    it "redirects to specialization step" do
        put :update, {
          id: "career_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Charm"]
          }
        }
      expect(response).to redirect_to(character_build_url(:specialization, character_id: Character.last.id))
    end
  end

  describe "specialization step" do
    before(:each) do
      @specialization = Specialization.where(name: "Assassin").first
    end

    it "assigns character" do
      get :show, {
        id: "specialization",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "renders specialization" do
      get :show, {
        id: "specialization",
        character_id: @character.id
      }
      expect(response).to render_template("build/specialization")
    end

    it "assigns specialization" do
      put :update, {
        id: "specialization",
        character_id: @character.id,
        character: {
          specialization_id: @specialization.id
        }
      }
      expect(@character.reload.specializations.first).to eq(@specialization)
    end

    it "redirects to species if they don't have one" do
      @character.update_attributes(species_id: nil)
      get :show, {
        id: "specialization",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:species, character_id: @character.id))
    end

    it "redirects to career if they don't have one" do
      @character.update_attributes(career_id: nil)
      get :show, {
        id: "specialization",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:career, character_id: @character.id))
    end
  end

  describe "specialization skills step" do
    it "assigns character" do
      get :show, {
        id: "specialization_skills",
        character_id: @character.id
      }
      expect(assigns(:character)).to eq(@character)
    end

    it "redirects to species if they don't have one" do
      @character.update_attributes(species_id: nil)
      get :show, {
        id: "specialization_skills",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:species, character_id: @character.id))
    end

    it "redirects to career if they don't have one" do
      @character.update_attributes(career_id: nil)
      get :show, {
        id: "specialization_skills",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:career, character_id: @character.id))
    end

    it "redirects to specialization if they don't have one" do
      @character.specializations.destroy_all
      get :show, {
        id: "specialization_skills",
        character_id: @character.id
      }
      expect(response).to redirect_to(character_build_url(:specialization, character_id: @character.id))
    end

    it "renders specialization_skills" do
      get :show, {
        id: "specialization_skills",
        character_id: @character.id
      }
      expect(response).to render_template("build/specialization_skills")
    end

    it "assigns specialization skills" do
      put :update, {
        id: "specialization_skills",
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
          id: "specialization_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(@character.skill("Astrogation").rank).to eq(0)
      end

      it "doesn't advance" do
        put :update, {
          id: "specialization_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(response).to render_template("build/specialization_skills")
      end

      it "sets flash message" do
        put :update, {
          id: "specialization_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Astrogation"]
          }
        }
        expect(flash[:error]).to eq("There was an error updating your character.")
      end
    end

    it "redirects to next step" do
        put :update, {
          id: "specialization_skills",
          character_id: @character.id,
          character: {
            optional_skills: ["Astrogation", "Charm"]
          }
        }
      expect(response).to redirect_to(character_build_url(:wicked_finish, character_id: Character.last.id))
    end
  end

end
