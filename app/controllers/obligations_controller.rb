class ObligationsController < ApplicationController
  before_filter :authorize
  before_filter :get_character

  layout "characters"

  def index
    if @character.base_obligation.blank?
      redirect_to base_obligation_url(@character)
    end
  end

  def base
  end

  private

  def get_character
    @character = current_user.characters.find(params[:character_id])
  end
end
