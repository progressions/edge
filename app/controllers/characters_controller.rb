class CharactersController < ApplicationController
  before_filter :require_login

  def index
    @characters = Character.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
  end

  def destroy
  end
end
