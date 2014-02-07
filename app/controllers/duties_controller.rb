class DutiesController < ApplicationController
  layout 'characters'

  def edit
    @character = current_user.characters.find(params[:id])
    @duties = Duty.all
    @character.duty_options ||= DutyOptions.create(starting_size: 10)
  end

  def duties
    @character = current_user.characters.find(params[:id])
    @duties = Duty.all
    @character.duty_options ||= DutyOptions.create(starting_size: 10)
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to edit_duty_url(@character)
  end

  def character_params
    params.require(:character).permit(character_duties_attributes: [:id, :duty_id, :size, :notes, :_destroy], duty_options_attributes: [:id, :starting_size, :plus_five_xp, :plus_ten_xp, :plus_thousand_credits, :plus_two_thousand_five_hundred_credits])
  end
end
