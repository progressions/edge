class CareersController < ApplicationController
  layout 'characters'

  def edit
    @careers = Career.all
    @character = current_user.characters.find(params[:id])
    @specializations = @character.career.specializations
  end

  def show
    @careers = Career.all
    @character = current_user.characters.find(params[:id])
    @specializations = @character.career.specializations
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
    params.require(:character).permit(:id, :career_id, :first_specialization_id)
  end
end
