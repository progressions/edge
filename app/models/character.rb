# == Schema Information
#
# Table name: characters
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  brawn       :integer          default(0), not null
#  agility     :integer          default(0), not null
#  intellect   :integer          default(0), not null
#  cunning     :integer          default(0), not null
#  willpower   :integer          default(0), not null
#  presence    :integer          default(0), not null
#  unused_xp   :integer          default(0), not null
#  used_xp     :integer          default(0), not null
#  species     :string(255)
#

class Character < ActiveRecord::Base
  belongs_to :user
  has_many :obligations

  accepts_nested_attributes_for :obligations, allow_destroy: true

  before_update do |character|
    character.apply_species if character.species_changed?
  end

  def total_obligation_amount
    obligations.sum(:amount)
  end

  def total_xp
    unused_xp.to_i + used_xp.to_i
  end

  protected

  def apply_species
    Rails.logger.info("species: #{species.downcase.underscore}")
    s = Species.get(species)
    s.generate(self)
  end
end
