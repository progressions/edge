class CareersController < ApplicationController
  include Ajaxy

  def show
    @careers = Career.all
    @character = current_user.characters.find(params[:id])
    @specializations = @character.career.specializations

    @career_skills = @character.char_skills_by_career
    @specialization_skills = @character.char_skills_by_specialization
  end
end
