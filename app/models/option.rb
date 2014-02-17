# == Schema Information
#
# Table name: options
#
#  id                      :integer          not null, primary key
#  option_choice_id        :integer
#  key                     :string(255)
#  name                    :string(255)
#  description             :text
#  starting_skill_training :boolean
#  skill_count             :integer
#  non_career              :boolean
#  created_at              :datetime
#  updated_at              :datetime
#  career                  :boolean
#

class Option < ActiveRecord::Base
  include Sluggable

  belongs_to :option_choice
  has_many :skill_trainings
  has_many :skill_modifiers, class_name: "OptionSkillModifier"

  def starting_skill_training_from_xml=(values={})
    values = [values].flatten
    values.each do |new_values|
      new_values[:option_id] = self.id
      Loader.load_single(SkillTraining, new_values)
    end
  end

  def skill_modifiers_from_xml=(values={})
    values = [values].flatten
    values.each do |new_values|
      new_values[:option_id] = self.id
      Loader.load_single(OptionSkillModifier, new_values)
    end
  end
end
