# == Schema Information
#
# Table name: character_specializations
#
#  id                :integer          not null, primary key
#  character_id      :integer
#  specialization_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class CharacterSpecialization < ActiveRecord::Base
end
