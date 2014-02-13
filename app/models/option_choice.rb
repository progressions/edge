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
    puts
    puts values.inspect
    puts
  end
end
