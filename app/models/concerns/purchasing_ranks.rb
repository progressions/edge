module PurchasingRanks
  extend ActiveSupport::Concern


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
