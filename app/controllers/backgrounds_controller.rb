class BackgroundsController < ApplicationController
  layout 'characters'

  def new
  end

  def update
  end

  def character_params
    params.require(:character).permit(:social_class, :background_hook, :story)
  end
end
