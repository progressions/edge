class ObligationsController < ApplicationController
  before_filter :authorize
  layout "characters"

  def index
    @character = current_user.characters.find(params[:character_id])
  end
end
