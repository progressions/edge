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

  include EasyHasOne

  easy_has_one :career
  easy_has_one :species

  before_save :default_obligation_options
  before_save :default_credits

  before_save :default_career
  before_save :default_specialization

  before_save :default_species
  before_save :default_characteristics

  before_save :update_duty_xp
  before_save :update_duty_credits

  before_save :update_species
  before_save :update_first_specialization

  before_save :update_obligation_xp
  before_save :update_obligation_credits

  before_save :default_skills

  def default_skills
    Skill.all.each do |skill|
      unless self.skills.include?(skill)
        self.skills << skill
      end
    end
  end

  def default_obligation_options
    self.obligation_options ||= self.create_obligation_options
  end

  def default_credits
    self.credits ||= 500
  end

  concerning :Characteristics do
    included do
      CHARACTERISTICS = [:brawn, :agility, :intellect, :cunning, :willpower, :presence]
    end

    def default_characteristics
      CHARACTERISTICS.each do |ch|
        default_characteristic(ch)
      end
    end

    def default_characteristic(ch)
      char = send(ch) || send("build_#{ch}")
      char.set_species_ranks(species.send(ch))
      char.save
    end

    def characteristic_amounts
      results = {}
      CHARACTERISTICS.each do |ch|
        results[ch] = send(ch).amount
      end
      results
    end
  end

  def update_first_specialization
    unless self.career.specializations.include?(self.first_specialization)
      self.first_specialization_id = self.career.specializations.first.id
    end

    if changed_attributes.include?(:first_specialization_id)
      self.career_skills_by_first_specialization.delete_all
      self.first_specialization.career_skills.each do |skill|
        self.career_skills_by_first_specialization << skill
      end
    end
  end

  def update_species
  end

  def default_species
    self.species ||= Species.where(name: "Human").first
  end

  def default_career
    self.career ||= Career.where(name: "Smuggler").first
  end

  def default_specialization
    self.first_specialization_id ||= self.career.specializations.first.id
  end

  def career_skill_ids
    career_skills.pluck(:id)
  end

  def career_skills_by_specialization_ids=(values)
    set_career_skill_ids(:specialization, values)
  end

  def career_skill_by_career_ids=(values)
    set_career_skill_ids(:career, values)
  end

  def career_skill_by_species_ids=(values)
    set_career_skill_ids(:species, values)
  end

  def set_career_skill_ids(source, values)
    values.each do |skill_id, value|
      skill = Skill.find(skill_id)
      if value.last == "true"
        self.send("career_skills_by_#{source}") << skill
      else
        self.send("career_skills_by_#{source}").delete(skill)
      end
    end
  end

=begin
  def career_id
    career.try(:id)
  end

  def career_id=(value)
    new_career = Career.find(value)
    unless new_career == self.career
      self.career_skills_by_career.delete_all
      self.career = new_career
      self.career_skills_by_career = self.career.career_skills
    end
  end

  def species_id
    species.try(:id)
  end

  def species_id=(value)
    new_species = Species.find(value)
    unless new_species == self.species
      self.career_skills_by_species.delete_all
      self.species = new_species
    end
  end
=end

  def starting_experience
    species.try(:starting_xp).to_i
  end

  def total_experience
    starting_experience + used_experience.to_i
  end

  def earned_experience_rank
  end

  def earned_experience
    0
  end

  def earned_experience=(amount)
  end

  def unused_experience
    total_experience.to_i - used_experience.to_i
  end

  def total_obligation
    obligations.sum(:size).to_i
  end

  def total_duty
    duties.sum(:size).to_i
  end

  def all_specializations
    ids = Array(specializations.pluck(:id))
    ids << first_specialization.id
    Specialization.where(id: ids)
  end

  def career_skill_ranks=(values)
    values.each do |skill_id, value|
      if value.last == "true"
        amount = 1
      else
        amount = 0
      end
      character_skill = self.character_skills.where(skill_id: skill_id).first
      character_skill.set_career_ranks(amount)
    end
  end

  def specialization_skill_ranks=(values)
    values.each do |skill_id, value|
      if value.last == "true"
        amount = 1
      else
        amount = 0
      end
      character_skill = self.character_skills.where(skill_id: skill_id).first
      character_skill.set_specialization_ranks(amount)
    end
  end

  def purchased_skill_ranks=(values)
    values.each do |cs_id, value|
      character_skill = self.character_skills.find(cs_id)
      character_skill.set_purchased_ranks(value)
    end
  end
end
