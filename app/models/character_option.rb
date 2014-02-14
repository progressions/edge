# == Schema Information
#
# Table name: character_options
#
#  id                   :integer          not null, primary key
#  character_species_id :integer
#  choice_key           :string(255)
#  option_key           :string(255)
#  skill_trainings      :text
#  created_at           :datetime
#  updated_at           :datetime
#

class CharacterOption < ActiveRecord::Base
  belongs_to :character_species

  serialize :skill_trainings, Hash

  def choice
    OptionChoice.where(key: choice_key).first
  end

  def option
    Option.where(key: option_key).first
  end
end
