class BackgroundsController < ApplicationController
  include Ajaxy

  layout 'characters'

  def edit
    @social_classes = SocialClass.all
    @backgrounds = Background.all
    @character = current_user.characters.find(params[:id])
  end
end
