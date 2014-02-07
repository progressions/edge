# == Schema Information
#
# Table name: species
#
#  id               :integer          not null, primary key
#  key              :string(255)
#  name             :string(255)
#  description      :text
#  brawn            :integer
#  agility          :integer
#  intellect        :integer
#  cunning          :integer
#  willpower        :integer
#  presence         :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#  starting_xp      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Species < ActiveRecord::Base
  has_many :characters, through: :character_species

  def starting_chars=(values)
    values.map do |k,v|
      if self.respond_to?("#{k.underscore}=".to_sym)
        self.update_attribute(k.underscore, v)
      end
    end
  end
end
