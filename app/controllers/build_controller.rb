# This controller covers creation of characters before Experience
# Points begin to be spent.
#
class BuildController < ApplicationController
  include Wicked::Wizard

  before_filter :authorize
  before_filter :check_for_character

  layout "characters"

  steps :start, :name, :party_size, :obligation, :confirm_obligation, :species,
    :species_attributes, :species_skills, :career, :career_skills, :specialization,
    :specialization_skills

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
        flash[:notice] = "Your obligation has been set."
      end
    when :species
      @all_species = Species.all
    when :species_attributes
      @character.species ||= Species.where(name: "Human").first
      @character.apply_species
      @character.save
      skip_step
    when :species_skills
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        redirect_to character_build_url(:species, character_id: @character.id) and return
      end

      @species = @character.species
      @character.apply_species
      flash[:notice] = "Your character has been updated."

      if @species.optional_skills?
        if @species.optional_skills.include?("all")
          @optional_skills = @character.skills.pluck(:name)
        else
          @optional_skills = @species.optional_skills
        end
      else
        skip_step
      end
    when :career
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        redirect_to character_build_url(:species, character_id: @character.id) and return
      end

      @all_species = Species.all
      @careers = Career.all
    when :career_skills
      unless @character.career.present?
        flash[:notice] = "Please choose a Career for your character."
        redirect_to character_build_url(:career, character_id: @character.id) and return
      end
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        redirect_to character_build_url(:species, character_id: @character.id) and return
      end

      @character.apply_career

      if @character.species_join.species_skills.any?
        @career_skills = @character.species_join.species_skills
      else
        @career_skills = Array.new(4, "")
      end

    when :specialization
      unless @character.career.present?
        flash[:notice] = "Please choose a Career for your character."
        redirect_to character_build_url(:career, character_id: @character.id) and return
      end
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        redirect_to character_build_url(:species, character_id: @character.id) and return
      end

      @specializations = @character.career.specializations
    when :specialization_skills
      unless @character.career.present?
        flash[:notice] = "Please choose a Career for your character."
        redirect_to character_build_url(:career, character_id: @character.id) and return
      end
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        redirect_to character_build_url(:species, character_id: @character.id) and return
      end
      unless @character.specializations.any?
        flash[:notice] = "Please choose a Species for your character."
        redirect_to character_build_url(:specialization, character_id: @character.id) and return
      end
    when :first_specialization_skills
      skip_step
    end
    render_wizard
  end

  def update
    @character = current_user.characters.find(params[:character_id])

    case step
    when "first_specialization"
      @character.specializations.destroy_all
    when "first_specialization_skills"
      @character.specializations_joins.first.update_attributes(career_skills: params[:character][:optional_skills])
    end

    @character.update_attributes(character_params)
    @species = @character.species
    @specializations = @character.try(:career).try(:specializations)

    if @species
      if @species.optional_skills.include?("all")
        @optional_skills = @character.skills.pluck(:name)
      else
        @optional_skills = @species.optional_skills
      end
    end

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
    params.require(:character).permit(:name, :species_id, :party_size, :base_obligation, :career_id, :specialization_id,
      optional_skills: [],
      skills_attributes: [:name, :rank, :id],
      obligations_attributes: [:amount, :name, :description, :"_destroy", :id])
  end

  def check_for_character
    unless params[:character_id].present?
      redirect_to build_character_url(:start, character_id: "new")
    end
  end
end
