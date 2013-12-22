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

  concerning :Steps do
    def start
      @character = current_user.characters.create
      @redirect_url ||= wizard_path(:name, character_id: @character.id)
    end

    def name
    end

    def party_size
    end

    def obligation
    end

    def confirm_obligation
      if @character.obligations.empty?
        @character.build_random_obligations!
        flash[:notice] = "Your obligation has been set."
      end
    end

    def species
      @all_species = Species.all
    end

    def species_attributes
      @character.species ||= Species.where(name: "Human").first
      @character.apply_species
      @character.save
      skip_step
    end

    def species_skills
      if @character.species.present?
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
      else
        flash[:notice] = "Please choose a Species for your character."
        @redirect_url ||= character_build_url(:species, character_id: @character.id)
      end
    end

    def career
      if @character.species.present?
        @all_species = Species.all
        @careers = Career.all
      else
        flash[:notice] = "Please choose a Species for your character."
        @redirect_url ||= character_build_url(:species, character_id: @character.id)
      end
    end

    def career_skills
      unless @character.career.present?
        flash[:notice] = "Please choose a Career for your character."
        @redirect_url ||= character_build_url(:career, character_id: @character.id)
      end
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        @redirect_url ||= character_build_url(:species, character_id: @character.id)
      end

      if @character.species.present? && @character.career.present?
        @character.apply_career

        if @character.species_join.species_skills.any?
          @career_skills = @character.species_join.species_skills
        else
          @career_skills = Array.new(4, "")
        end
      end
    end

    def specialization
      unless @character.career.present?
        flash[:notice] = "Please choose a Career for your character."
        @redirect_url ||= character_build_url(:career, character_id: @character.id)
      end
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        @redirect_url ||= character_build_url(:species, character_id: @character.id)
      end

      if @character.career.present? && @character.species.present?
        @specializations = @character.career.specializations
      end
    end

    def specialization_skills
      unless @character.career.present?
        flash[:notice] = "Please choose a Career for your character."
        @redirect_url ||= character_build_url(:career, character_id: @character.id)
      end
      unless @character.species.present?
        flash[:notice] = "Please choose a Species for your character."
        @redirect_url ||= character_build_url(:species, character_id: @character.id)
      end
      unless @character.specializations.any?
        flash[:notice] = "Please choose a Species for your character."
        @redirect_url ||= character_build_url(:specialization, character_id: @character.id)
      end
    end

    def first_specialization_skills
      skip_step
    end

    def wicked_finish
    end
  end

  def show
    unless params[:character_id] == "new"
      @character = current_user.characters.find(params[:character_id])
    end

    if step.present?
      send(step)
    end

    if @redirect_url.present?
      redirect_to @redirect_url and return
    else
      render_wizard
    end
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
      species_skills: [],
      skills_attributes: [:name, :rank, :id],
      obligations_attributes: [:amount, :name, :description, :"_destroy", :id])
  end

  def check_for_character
    unless params[:character_id].present?
      redirect_to build_character_url(:start, character_id: "new")
    end
  end
end
