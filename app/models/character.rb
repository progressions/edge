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
#  species          :string(255)
#  party_size       :integer
#  base_obligation  :integer
#  wound_threshold  :integer
#  strain_threshold :integer
#

class Character < ActiveRecord::Base
  belongs_to :user
  has_many :obligations
  has_many :skills

  accepts_nested_attributes_for :obligations, allow_destroy: true
  accepts_nested_attributes_for :skills

  before_update :apply_species
  before_update :set_base_obligation
  before_create :set_default_skills

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

  def set_optional_skills(skills_json)
    optional_skills = JSON.parse(skills_json)
    optional_skills.each do |skill_name|
      add_rank_to_skill(skill_name, 1)
      skill_to_change = skill(skill_name)
      skill_to_change.rank += 1
      skill_to_change.species = true
    end
    skills.update_all(species: false)
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

  def apply_species
    if species_changed?
      s = Species.get(species, self)
      s.generate
    end
  end

  def set_default_skills
    SKILLS.each do |category, category_skills|
      category_skills.each do |key, values|
        self.skills.new(values.merge(rank: 0, category: category))
      end
    end
  end
end
