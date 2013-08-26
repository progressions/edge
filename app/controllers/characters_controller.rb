class CharactersController < ApplicationController
  before_filter :require_login

  def index
    @characters = current_user.characters
  end

  def new
    @character = current_user.characters.build
  end

  def create
    @character = current_user.characters.build(params[:character].permit(:name))
    if @character.save
      redirect_to root_url, notice: "Character created."
    else
      render :new
    end
  end

  def edit
    @character = current_user.characters.find(params[:id])
  end

  def update
  end

  def show
    @character = current_user.characters.find(params[:id])
  end

  def destroy
  end
end
