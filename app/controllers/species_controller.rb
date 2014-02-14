class SpeciesController < ApplicationController
  layout 'characters'

  def edit
    @species = Species.official
    @character = current_user.characters.find(params[:id])
  end

  def show
    @species = Species.official
    @character = current_user.characters.find(params[:id])
    @option_choices = @character.species.option_choices.joins(:options)
    @non_career_skills = @character.character_skills.reject do |skill|
      skill.career? && skill.species_amount < 1
    end
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to edit_species_url(@character)
  end

  def character_params
    params.require(:character).permit(:id, :species_id)
  end
end
