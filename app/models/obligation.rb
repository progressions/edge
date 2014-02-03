# == Schema Information
#
# Table name: obligations
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  source      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Obligation < ActiveRecord::Base
  has_many :character_obligations
  has_many :characters, through: :character_obligation

  def self.from_xml(hash)
    obligation_params = {
      key: hash["Key"],
      name: hash["Name"],
      description: hash["Description"]
    }
    create(obligation_params)
  end
end
