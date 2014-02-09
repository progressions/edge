# == Schema Information
#
# Table name: characters
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :text
#  user_id                 :integer
#  created_at              :datetime
#  updated_at              :datetime
#  player_name             :string(255)
#  gender                  :string(255)
#  age                     :string(255)
#  height                  :string(255)
#  build                   :string(255)
#  hair                    :string(255)
#  eyes                    :string(255)
#  notable_features        :text
#  credits                 :integer
#  used_experience         :integer
#  portrait_file_name      :string(255)
#  portrait_content_type   :string(255)
#  portrait_file_size      :integer
#  portrait_updated_at     :datetime
#  story                   :text
#  social_class_id         :integer
#  background_id           :integer
#  first_specialization_id :integer
#

class Character < ActiveRecord::Base
  include CharacterAssociations
  include CharacterXml
  include CharacterObligationDuty
  include CharacterExperience
  include CharacterCharacteristics
  include CharacterCallbacks
  include CharacterCareerSkills

  before_save :default_obligation_options
  before_save :default_credits

  before_save :default_career
  before_save :default_specialization

  before_save :default_species
  before_create :default_characteristics

  before_save :update_duty_xp
  before_save :update_duty_credits

  before_save :update_species
  before_save :update_first_specialization

  before_save :update_obligation_xp
  before_save :update_obligation_credits

  before_save :default_skills

  def all_specializations
    ids = Array(specializations.pluck(:id))
    ids << first_specialization.id
    Specialization.where(id: ids)
  end

  def purchased_skill_ranks=(values)
    values.each do |cs_id, value|
      character_skill = self.character_skills.find(cs_id)
      character_skill.set_purchased_ranks(value)
    end
  end
end
