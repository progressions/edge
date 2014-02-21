module CharacterAssociations
  extend ActiveSupport::Concern

  included do
    has_many :character_talent_boxes
    has_many :talent_boxes, through: :character_talent_boxes

    has_many :character_options, through: :character_species

    has_one :experience

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

    has_one :character_species, dependent: :destroy
    has_one :species, through: :character_species
    accepts_nested_attributes_for :species

    belongs_to :user

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

    has_one :brawn, -> { where(key: "BR", name: "Brawn") }, class_name: "Characteristic"
    has_one :agility, -> { where(key: "AG", name: "Agility") }, class_name: "Characteristic"
    has_one :intellect, -> { where(key: "IN", name: "Intellect") }, class_name: "Characteristic"
    has_one :cunning, -> { where(key: "CU", name: "Cunning") }, class_name: "Characteristic"
    has_one :willpower, -> { where(key: "WI", name: "Willpower") }, class_name: "Characteristic"
    has_one :presence, -> { where(key: "PR", name: "Presence") }, class_name: "Characteristic"
  end
end
