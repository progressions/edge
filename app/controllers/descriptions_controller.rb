class DescriptionsController < ApplicationController
  layout 'characters'

  def new
    @character = current_user.characters.find(params[:id])
  end

  def create
    @character = current_user.characters.find(params[:id])
  end
end
