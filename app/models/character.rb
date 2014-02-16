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
  include EasyHasOne

  easy_has_one :career
  easy_has_one :species

  include CharacterAssociations
  include CharacterXml
  include CharacterObligationDuty
  include CharacterExperience
  include CharacterCharacteristics
  include CharacterCallbacks
  include CharacterCareerSkills
  include CharacterFreeSkillRanks

  before_save :default_experience

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

  def species_option_for_choice(choice)
    selected_char_option = self.character_options.where(choice_key: choice.key).first
    choice.options.where(key: selected_char_option.try(:option_key)).first
  end

  def species_option=(value)
    option = Option.find(value)
    choice = option.option_choice
    opt = self.character_options.where(choice_key: choice.key).first
    opt ||= self.character_options.build(choice_key: choice.key)
    opt.character_species_id = self.character_species.id
    opt.option_key = option.key
    opt.save!
  end

  def purchased_char_ranks=(values)
    values.each do |c_id, value|
      characteristic = self.characteristics.find(c_id)

      characteristic.set_purchased_ranks(value)
    end
  end

  def purchased_skill_ranks=(values)
    values.each do |cs_id, value|
      character_skill = self.character_skills.find(cs_id)
      character_skill.set_purchased_ranks(value)
    end
  end
end
