class SpeciesController < ApplicationController
  layout 'characters'

  def edit
    @species = Species.all
    @character = current_user.characters.find(params[:id])
  end
end
