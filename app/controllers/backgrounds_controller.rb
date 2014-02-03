class BackgroundsController < ApplicationController
  layout 'characters'

  def edit
    @social_classes = SocialClass.all
    @backgrounds = Background.all
    @character = current_user.characters.find(params[:id])
  end

  def update
    @character = current_user.characters.find(params[:id])

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to edit_background_url(@character)
  end

  def character_params
    params.require(:character).permit(:social_class_id, :background_id, :story)
  end
end
