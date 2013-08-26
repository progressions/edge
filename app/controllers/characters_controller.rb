class CharactersController < ApplicationController
  before_filter :require_login

  def index
    @characters = Character.all
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(params[:character])
    if @character.save
      redirect_to root_url, notice: "Character created."
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def destroy
  end
end
