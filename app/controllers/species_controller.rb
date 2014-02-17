class SpeciesController < ApplicationController
  include Ajaxy

  def show
    @species = Species.official
    @character = current_user.characters.find(params[:id])
    @option_choices = @character.species.option_choices.joins(:options).uniq
    @non_career_skills = @character.character_skills.reject do |skill|
      skill.career? && skill.species_amount < 1
    end
  end
end
