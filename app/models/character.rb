# == Schema Information
#
# Table name: characters
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  description      :text
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  brawn            :integer          default(0), not null
#  agility          :integer          default(0), not null
#  intellect        :integer          default(0), not null
#  cunning          :integer          default(0), not null
#  willpower        :integer          default(0), not null
#  presence         :integer          default(0), not null
#  unused_xp        :integer          default(0), not null
#  used_xp          :integer          default(0), not null
#  party_size       :integer
#  base_obligation  :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#  species_id       :integer
#  career_id        :integer
#

class Character < ActiveRecord::Base

  belongs_to :career
  belongs_to :species
  belongs_to :user
  has_many :obligations
  has_many :skills

  has_many :character_specializations
  has_many :specializations, through: :character_specializations

  accepts_nested_attributes_for :obligations, allow_destroy: true
  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :specializations

  before_update :set_base_obligation
  before_create :set_default_skills

  validate do |user|
    if Array(@optional_skills).uniq != Array(@optional_skills)
      errors.add(:base, "Species skills must be unique.")
    end
  end

  def total_obligation_amount
    obligations.sum(:amount)
  end

  def total_xp
    unused_xp.to_i + used_xp.to_i
  end

  def build_random_obligations!
    random_obligations = obligations.randomize
    obligation_amount = self.base_obligation.to_i / random_obligations.length

    random_obligations.each do |obligation|
      obligation.amount = obligation_amount
      obligations << obligation
    end
  end

  def add_rank_to_skill(skill_name, rank=1)
    skill_to_change = skill(skill_name)
    if skill_to_change.present?
      skill_to_change.rank += rank
      skill_to_change.save!
    end
  end

  def skill(name)
    skills.where(name: name).first
  end

  def optional_skills=(optional_skills)
    @optional_skills = Array(optional_skills)
    if valid?
      @optional_skills.each do |skill_name|
        begin
          add_rank_to_skill(skill_name, 1)
          skill_to_change = skill(skill_name)
          skill_to_change.rank += 1
        rescue StandardError => e
          Rails.logger.info("Blew up on '#{skill_name}'")
        end
      end
    end
  end

  def apply_career
    skills.where(name: career.career_skills).update_all(career: true)
  end

  def apply_species
    assign_attributes(species.characteristics)
    assign_attributes(wound_threshold: species.wound_threshold)
    assign_attributes(strain_threshold: species.strain_threshold)
    assign_attributes(unused_xp: species.unused_xp)
    reset_skills
    optional_skills = species.starting_skills
  end

  def set_species(species_name)
    self.species = Species.where(name: species_name).first
    if species.nil?
      raise "Species #{species_name} does not exist"
    end

    apply_species
  end

  def set_career(career_name)
    self.career = Career.where(name: career_name).first
    if career.nil?
      raise "Career #{career_name} does not exist"
    end

    apply_career
  end

  def reset_skills
    skills.reset_all
  end

  def specialization_id=(spec_id)
    specializations << Specialization.where(id: spec_id).first
  end

  protected

  def set_base_obligation
    party_to_obligation = {
      2 => 20,
      3 => 15,
      4 => 10,
      5 => 10,
      6 => 5
    }
    self.base_obligation = party_to_obligation[self.party_size.to_i]
  end

  def set_default_skills
    SKILLS.each do |category, category_skills|
      category_skills.each do |key, values|
        self.skills.new(values.merge(rank: 0, category: category))
      end
    end
  end
end
