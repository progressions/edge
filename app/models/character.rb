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
  has_many :character_skills
  has_many :skills, through: :character_skills

  has_many :character_career_skills
  has_many :career_skills, through: :character_career_skills, source: :skill

  has_many :career_character_career_skills, -> { where(source: "career") }, class_name: "CharacterCareerSkill"
  has_many :career_skills_by_career, through: :career_character_career_skills, source: :skill

  has_many :species_character_career_skills, -> { where(source: "species") }, class_name: "CharacterCareerSkill"
  has_many :career_skills_by_species, through: :species_character_career_skills, source: :skill

  has_many :specialization_character_career_skills, -> { where(source: "specialization") }, class_name: "CharacterCareerSkill"
  has_many :career_skills_by_specialization, through: :specialization_character_career_skills, source: :skill

  has_many :first_specialization_character_career_skills, -> { where(source: "first_specialization") }, class_name: "CharacterCareerSkill"
  has_many :career_skills_by_first_specialization, through: :first_specialization_character_career_skills, source: :skill


  has_many :character_specializations
  has_many :specializations, through: :character_specializations

  belongs_to :first_specialization, class_name: "Specialization"

  has_one :character_career
  has_one :career, through: :character_career

  has_many :characteristics

  has_one :character_species
  has_one :species, through: :character_species
  accepts_nested_attributes_for :species

  belongs_to :user

  has_many :rankables, foreign_key: "parent_id", dependent: :destroy
  has_many :experience_ranks, through: :rankables, source: :rank, class_name: "ExperienceRank"

  belongs_to :social_class
  belongs_to :background

  has_one :duty_options
  accepts_nested_attributes_for :duty_options

  has_many :character_duties
  has_many :duties, through: :character_duties

  has_one :obligation_options
  accepts_nested_attributes_for :obligation_options

  has_many :character_obligations
  has_many :obligations, through: :character_obligations

  accepts_nested_attributes_for :character_obligations, allow_destroy: true
  accepts_nested_attributes_for :obligations

  accepts_nested_attributes_for :character_duties, allow_destroy: true
  accepts_nested_attributes_for :duties

  has_attached_file :portrait, :styles => { :medium => "300x300", :thumb => "100x100#" }, :default_url => "/assets/:style/missing.jpg"
  validates_attachment_content_type :portrait, :content_type => /\Aimage\/.*\Z/

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

  has_one :brawn, -> { where(key: "BR", name: "Brawn") }, class_name: "Characteristic"
  has_one :agility, -> { where(key: "AG", name: "Agility") }, class_name: "Characteristic"
  has_one :intellect, -> { where(key: "IN", name: "Intellect") }, class_name: "Characteristic"
  has_one :cunning, -> { where(key: "CU", name: "Cunning") }, class_name: "Characteristic"
  has_one :willpower, -> { where(key: "WI", name: "Willpower") }, class_name: "Characteristic"
  has_one :presence, -> { where(key: "PR", name: "Presence") }, class_name: "Characteristic"

  CHARACTERISTICS = [:brawn, :agility, :intellect, :cunning, :willpower, :presence]

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

  def default_characteristics
    CHARACTERISTICS.each do |ch|
      default_characteristic(ch)
    end
  end

  def default_characteristic(ch)
    char = send(ch) || send("build_#{ch}")
    char.add_rank(:species, species.send(ch))
    char.save
  end

  def characteristic_amounts
    results = {}
    CHARACTERISTICS.each do |ch|
      results[ch] = send(ch).amount
    end
    results
  end

  def update_first_specialization
    unless self.career.specializations.include?(self.first_specialization)
      self.first_specialization_id = self.career.specializations.first.id
    end
    if changed_attributes.include?(:first_specialization_id)
      self.career_skills_by_first_specialization = self.first_specialization.career_skills
    end
  end

  def update_species
    rank = experience_ranks.by_species.first || experience_ranks.by_species.build
    rank.amount = species.starting_xp
    rank.save
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
      self.career = new_career
    end
  end

  def starting_experience
    species.try(:starting_xp).to_i
  end

  def total_experience
    starting_experience + experience_ranks.sum(:amount).to_i + used_experience.to_i
  end

  def earned_experience_rank
    experience_ranks.where(source: :purchased).first || experience_ranks.create(source: :purchased, amount: 0)
  end

  def earned_experience
    earned_experience_rank.amount
  end

  def earned_experience=(amount)
    earned_experience_rank.update_attributes(amount: amount)
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

  def purchased_skill_ranks=(values)
    values.each do |cs_id, value|
      character_skill = self.character_skills.find(cs_id)
      character_skill.purchase_ranks(value)
    end
  end

  concerning :UpdatingObligationOptions do
    def update_obligation_credits
      return unless obligation_options.present?

      amount = self.credits.to_i

      if obligation_options.changes["plus_thousand_credits"] == [false, true]
        amount += 1000
      elsif obligation_options.changes["plus_thousand_credits"] == [true, false]
        amount -= 1000
      end

      if obligation_options.changes["plus_two_thousand_five_hundred_credits"] == [false, true]
        amount += 2500
      elsif obligation_options.changes["plus_two_thousand_five_hundred_credits"] == [true, false]
        amount -= 2500
      end

      self.credits = amount
    end

    def update_obligation_xp
      return unless obligation_options.present?

      amount = 0
      if obligation_options.plus_five_xp
        amount += 5
      end
      if obligation_options.plus_ten_xp
        amount += 10
      end
      obligation_rank.update_attribute(:amount, amount)
    end
  end

  concerning :UpdatingDutyOptions do
    def update_duty_credits
      return unless duty_options.present?

      amount = self.credits.to_i

      if duty_options.changes["plus_thousand_credits"] == [false, true]
        amount += 1000
      elsif duty_options.changes["plus_thousand_credits"] == [true, false]
        amount -= 1000
      end

      if duty_options.changes["plus_two_thousand_five_hundred_credits"] == [false, true]
        amount += 2500
      elsif duty_options.changes["plus_two_thousand_five_hundred_credits"] == [true, false]
        amount -= 2500
      end

      self.credits = amount
    end

    def update_duty_xp
      return unless duty_options.present?

      amount = 0
      if duty_options.plus_five_xp
        amount += 5
      end
      if duty_options.plus_ten_xp
        amount += 10
      end
      duty_rank.update_attribute(:amount, amount)
    end
  end

  concerning :Ranks do
    def duty_rank
      experience_ranks.by_duty.first || experience_ranks.build(source: "duty")
    end

    def obligation_rank
      experience_ranks.by_obligation.first || experience_ranks.build(source: "obligation")
    end
  end

  def self.from_xml(xml)
    hash = Hash.from_xml(xml)
    character_params = {}

    description_hash = hash["Character"]["Description"]
    character_params[:name] = description_hash["CharName"]
    character_params[:player_name] = description_hash["PlayerName"]
    character_params[:gender] = description_hash["Gender"]
    character_params[:age] = description_hash["Age"]
    character_params[:height] = description_hash["Height"]
    character_params[:build] = description_hash["Build"]
    character_params[:hair] = description_hash["Hair"]
    character_params[:eyes] = description_hash["Eyes"]
    character_params[:notable_features] = description_hash["OtherFeatures"]

    social_class_slug = hash["Character"]["Class"]["ClassKey"]
    background_slug = hash["Character"]["Hook"]["HookKey"]

    character_params[:social_class] = SocialClass.lookup(social_class_slug)
    character_params[:background] = Background.lookup(background_slug)

    create(character_params)
  end

  def to_xml(options = {})
    require 'builder'
    options[:indent] ||= 2
    xml = options[:builder] ||= ::Builder::XmlMarkup.new(indent: options[:indent])
    xml.instruct! unless options[:skip_instruct]
    xml.tag!(:Character) do
      xml.tag!(:Description) do
        xml.tag!(:CharName, name)
        xml.tag!(:PlayerName, player_name)
        xml.tag!(:Gender, gender)
        xml.tag!(:Age, age)
        xml.tag!(:Height, height)
        xml.tag!(:Build, build)
        xml.tag!(:Hair, hair)
        xml.tag!(:Eyes, eyes)
        xml.tag!(:OtherFeatures, notable_features)
      end
      xml.tag!(:Class) do
        xml.tag!(:ClassKey, social_class.slug)
      end
      xml.tag!(:Hook) do
        xml.tag!(:HookKey, background.slug)
      end
    end
  end

end
