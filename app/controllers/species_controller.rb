class SpeciesController < ApplicationController
  before_filter :authorize
  layout "characters"

  def index
    @character = current_user.characters.find(params[:character_id])
    @species = [
      "Human",
      "Rodian",
      "Twi'lek",
      "Bothan",
      "Gand",
      "Droid",
      "Trandoshan",
      "Wookiee"
    ].sort
  end
end
