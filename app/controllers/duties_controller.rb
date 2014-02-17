class DutiesController < ApplicationController
  include Ajaxy

  def show
    @character = current_user.characters.find(params[:id])
    @duties = Duty.all
    @character.duty_options ||= DutyOptions.create(starting_size: 10)
  end
end
