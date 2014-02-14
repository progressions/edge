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
  belongs_to :option_choice

  def starting_skill_training_from_xml=(values={})
    values = [values].flatten
    puts
    puts values.inspect
    puts
    values.each do |new_values|
      new_values[:option_id] = self.id
      puts
      puts new_values.inspect
      puts
      new_values["Requirement"] = [new_values["Requirement"]].flatten
      Loader.load_single(SkillTraining, new_values)
    end
  end
end
