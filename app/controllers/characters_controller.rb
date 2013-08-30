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

  def new
    @character = current_user.characters.build
    render 'name', layout: "application"
  end

  def create
    @character = current_user.characters.build(params[:character].permit(:name))
    if @character.save
      redirect_to new_character_obligation_url(@character)
    else
      render :new
    end
  end

  def edit
    @character = current_user.characters.find(params[:id])
  end

  def update
    Rails.logger.info(character_params.inspect)
    @character = current_user.characters.find(params[:id])
    @character.update_attributes!(character_params)
    redirect_to @character
  end

  def show
    @character = current_user.characters.find(params[:id])
  end

  def destroy
  end

  private

  def character_params
    params.require(:character).permit(:name, obligations_attributes: [:amount, :name, :description, :"_destroy", :id])
  end
end
