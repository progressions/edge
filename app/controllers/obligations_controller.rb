class ObligationsController < ApplicationController
  layout 'characters'

  def edit
    @character = current_user.characters.find(params[:id])
    @obligations = Obligation.all
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to edit_obligation_url(@character)
  end

  def character_params
    params.require(:character).permit(character_obligations_attributes: [:id, :obligation_id, :size, :notes, :_destroy])
  end
end
