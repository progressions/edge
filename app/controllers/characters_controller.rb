class CharactersController < ApplicationController
  before_filter :authorize, except: [:index, :new]

  def index
    if current_user
      @characters = current_user.characters
    else
      @characters = []
    end
    render layout: "application"
  end

  def import
    character_io = params[:character]

    character_xml = Nokogiri.parse(character_io.read)

    character_params = {}

    character_params[:name] = character_xml.css("CharName").text

    @character = current_user.characters.create(character_params)

    redirect_to characters_url
  end

  def export
  end

  def copy
    @character = current_user.characters.find(params[:id])

    @new_character = @character.dup
    if @new_character.save
      flash[:notice] = "Your character has been copied."
    else
      flash[:notice] = "There was a problem copying your character."
    end

    redirect_to characters_url
  end

  def new
    @character = current_user.characters.create
    redirect_to character_build_url(:name, character_id: @character.id)
  end

  def show
    @character = current_user.characters.find(params[:id])
    @specializations = @character.specializations.map(&:full_name)
  end

  def destroy
    @character = current_user.characters.find(params[:id])
    if @character.destroy
      flash[:notice] = "Your character has been deleted."
    else
      flash[:notice] = "There was a problem deleting your character."
    end
    redirect_to characters_url
  end
end
