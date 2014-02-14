# == Schema Information
#
# Table name: option_choices
#
#  id         :integer          not null, primary key
#  species_id :integer
#  key        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class OptionChoice < ActiveRecord::Base
  belongs_to :species
  has_many :options

  def options_from_xml=(values)
    values = [values].flatten
    values.each do |new_values|
      new_values[:option_choice_id] = self.id
      Loader.load_single(Option, new_values)
    end
  end
end
