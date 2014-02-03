class BackgroundsController < ApplicationController
  layout 'characters'

  def new
    @social_classes = ["Down and Out", "Middle Class Struggles", "High and Mighty", "The Outsider"]
    @backgrounds = ["Opportunity Knocks", "Higher Calling", "Enemies and Antagonists", "Failure of Character", "Wrong Place, Wrong Time", "Academic", "Criminal", "Entrepreneur", "Ex-Imperial Operator", "Fallen Noble", "Wanderer"]
    @character = current_user.characters.find(params[:id])
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to new_background_url(@character)
  end

  def character_params
    params.require(:character).permit(:social_class, :background, :story)
  end
end
