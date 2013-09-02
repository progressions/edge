class SpeciesController < ApplicationController
  before_filter :authorize
  layout "characters"

  def index
    @character = current_user.characters.find(params[:character_id])
    @all_species = Species.all(@character)
    @species = Species.get(@character.species, @character)
  end
end
