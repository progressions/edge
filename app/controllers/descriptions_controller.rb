class DescriptionsController < ApplicationController
  layout 'characters'

  def new
    @character = current_user.characters.find(params[:id])
  end

  def update
    @character = current_user.characters.find(params[:id])


    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to new_description_url(@character)
  end

  def character_params
    params.require(:character).permit(:name, :player_name, :gender, :age, :height, :build, :hair,
      :eyes, :notable_features, :credits, :earned_experience, :portrait)
  end
end
