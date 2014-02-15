# == Schema Information
#
# Table name: ranks
#
#  id          :integer          not null, primary key
#  amount      :integer
#  source      :string(255)
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  parent_type :string(255)
#  parent_id   :integer
#

class CareerRank < Rank
  belongs_to :characteristic, -> { joins(:ranks).where("ranks.parent_type = ?", "Characteristic") }, foreign_key: "parent_id"
  belongs_to :character_skill, -> { joins(:ranks).where("ranks.parent_type = ?", "CharacterSkill") }, foreign_key: "parent_id"
end
