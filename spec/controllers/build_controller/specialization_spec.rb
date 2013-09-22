require 'spec_helper'

describe BuildController do
  before(:each) do
    Species.seed!
    Career.seed!

    @species = Species.where(name: "Human").first

    @user = create(:user)
    @character = create(:character, user: @user, species: @species)
    @character_with_specialization = create(:character_with_specialization, user: @user, species: @species)
    controller.stub(:current_user).and_return(@user)
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
        id: "first_specialization",
        character_id: @character.id,
        character: {
          specialization_id: @specialization.id
        }
      }
      expect(@character.reload.specializations.first).to eq(@specialization)
    end

    it "wipes specializations" do
      @character.specializations << create(:specialization)
      @character.specializations << create(:specialization)

      put :update, {
        id: "first_specialization",
        character_id: @character.id,
        character: {
          specialization_id: @specialization.id
        }
      }
      @character.reload

      expect(@character.specializations.count).to eq(1)
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
        character_id: @character_with_specialization.id
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
          character_id: @character_with_specialization.id,
          character: {
            optional_skills: ["Astrogation", "Charm"]
          }
        }
      expect(response).to redirect_to(character_build_url(:wicked_finish, character_id: @character_with_specialization.id))
    end
  end
end
