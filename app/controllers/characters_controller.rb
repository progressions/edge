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

  def details
    @character = current_user.characters.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def import
    character_io = params[:character]

    @character = current_user.characters.from_xml(character_io.read)

    redirect_to characters_url
  end

  def export
    @character = current_user.characters.find(params[:id])

    respond_to do |format|
      format.html { send_data(@character.to_xml, filename: "#{@character.name}.xml") }
      format.xml
    end
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
    redirect_to edit_description_url(id: @character)
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
