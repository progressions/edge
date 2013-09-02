class CharactersController < ApplicationController
  before_filter :authorize, except: [:index, :new]

  def index
    if current_user
      @characters = current_user.characters
    else
      @characters = []
    end
    render layout: "application"
  end

  def new
    @character = current_user.characters.build
    render 'name', layout: "application"
  end

  def create
    @character = current_user.characters.build(params[:character].permit(:name))
    if @character.save
      flash[:notice] = "Your character has been updated."
      redirect_to next_creation_url(@character)
    else
      flash[:error] = "There was a problem saving your character."
      render :new
    end
  end

  def edit
    @character = current_user.characters.find(params[:id])
  end

  def update
    @character = current_user.characters.find(params[:id])
    if params[:commit] == "Random Obligation"
      @character.build_random_obligations!
      flash[:notice] = "Your character has been updated."
      redirect_to character_obligations_url(@character)
    elsif params[:character]
      @character_params = character_params
      optional_skills_json = @character_params.delete(:optional_skills)
      @character.update_attributes!(@character_params)

      if optional_skills_json.present?
        @character.set_optional_skills(optional_skills_json)
      end

      flash[:notice] = "Your character has been updated."
      redirect_to next_creation_url(@character)
    end
  end

  def show
    @character = current_user.characters.find(params[:id])
  end

  def destroy
    @character = current_user.characters.find(params[:id])
    if @character.destroy
      flash[:notice] = "Your character has been deleted."
    else
      flash[:notice] = "There was a problem deleting your character."
    end
    redirect_to characters_url
  end

  private

  def character_params
    params.require(:character).permit(:name, :species, :party_size, :base_obligation,
      :optional_skills,
      skills_attributes: [:name, :rank, :id],
      obligations_attributes: [:amount, :name, :description, :"_destroy", :id])
  end
end
