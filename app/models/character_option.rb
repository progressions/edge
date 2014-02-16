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
    OptionChoice.lookup(option_key)
  end

  def option
    Option.lookup(option_key)
  end

  def skill_modifiers
    return [] unless option.present?

    option.skill_modifiers
  end
end
