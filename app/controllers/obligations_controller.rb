class ObligationsController < ApplicationController
  include Ajaxy

  def show
    @character = current_user.characters.find(params[:id])
    @obligations = Obligation.all
    @character.obligation_options ||= ObligationOptions.create(starting_size: 10)
  end
end
