class SpecializationsController < ApplicationController
  include Ajaxy

  def load_values
    @specializations = @character.specializations
  end
end
