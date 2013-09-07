class BuildController < ApplicationController
  include Wicked::Wizard

  before_filter :authorize
  layout "characters"

  steps :start, :name, :party_size, :obligation, :confirm_obligation, :species, :species_attributes, :species_skills

  def show
    unless params[:character_id] == "new"
      @character = current_user.characters.find(params[:character_id])
    end

    case step
    when :start
      @character = current_user.characters.create
      redirect_to wizard_path(:name, character_id: @character.id) and return
    when :confirm_obligation
      if @character.obligations.empty?
        @character.build_random_obligations!
      end
    when :species
      @all_species = Species.all(@character)
      @species = Species.get(@character.species, @character)
    when :species_attributes
      @species = Species.get(@character.species, @character)
      @species.generate
      @character.save
      skip_step
    when :species_skills
      @species = Species.get(@character.species, @character)

      unless @species.optional_skills?
        skip_step
      end
    end
    render_wizard
  end

  def update
    @character = current_user.characters.find(params[:character_id])
    @character.update_attributes(character_params)
    @species = Species.get(@character.species, @character)

    if @character.valid?
      flash[:notice] = "Your character has been updated."
    else
      flash[:error] = "There was an error updating your character."
    end

    render_wizard @character
  end

  def finish_wizard_path
    character_url(@character)
  end

  private

  def character_params
    params.require(:character).permit(:name, :species, :party_size, :base_obligation,
      optional_skills: [],
      skills_attributes: [:name, :rank, :id],
      obligations_attributes: [:amount, :name, :description, :"_destroy", :id])
  end
end
