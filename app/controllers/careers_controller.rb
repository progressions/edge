class CareersController < ApplicationController
  layout 'characters'

  def edit
    @character = current_user.characters.find(params[:id])
  end

  def show
    @careers = Career.all
    @character = current_user.characters.find(params[:id])
    @specializations = @character.career.specializations
    @career_skills = @character.career.career_skills
    @specialization_skills = @character.first_specialization.career_skills
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to edit_career_url(@character)
  end

  def character_params
    params.require(:character).permit! #(:id, :career_id, :first_specialization_id, :career_skill_ids)
  end
end
