class SkillsController < ApplicationController
  include Ajaxy

  def show
    @character = current_user.characters.find(params[:id])
    @character_skills = @character.character_skills
  end
end
