class ObligationsController < ApplicationController
  before_filter :authorize
  layout "characters"

  def new
    @character = current_user.characters.find(params[:character_id])
  end

  def index
    @character = current_user.characters.find(params[:character_id])
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
