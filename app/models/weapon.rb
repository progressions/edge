# == Schema Information
#
# Table name: weapons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :text
#  skill_key   :string(255)
#  damage      :integer
#  crit        :integer
#  range       :string(255)
#  encumbrance :integer
#  hp          :integer
#  price       :integer
#  rarity      :integer
#  weapon_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Weapon < ActiveRecord::Base
end
