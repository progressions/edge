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
      expect(@character.career_skills.count).to eq(8)
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
      expect(response).to redirect_to(character_build_url(:specialization, character_id: @character.id))
    end
  end
end
