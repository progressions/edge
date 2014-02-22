module BuyingSpecializations
  extend ActiveSupport::Concern

  def remove_box(box)
    character_talent = self.character_talents.where(talent_id: box.talent.id).first
    rank = character_talent.try(:purchased_amount)

    self.talent_boxes.delete(box)

    if rank.to_i > 0
      character_talent.set_purchased_rank(rank.to_i - 1)
    end
  end

  def talent_box_id=(values)
    values.each do |key, value|
      box = TalentBox.find(key)
      character_talent = self.character_talents.where(talent_id: box.talent.id).first
      rank = character_talent.try(:purchased_amount)

      if value.last == "true"
        self.talent_boxes << box

        character_talent.set_purchased_rank(rank.to_i + 1)
      else
        remove_box(box)
      end

      self.character_talent_boxes.each do |ctb|
        rank = ctb.purchased_amount.to_i

        unless ctb.valid_box?
  remove_box(ctb.talent_box)
        end
      end
    end
  end

  def can_buy?(box)
    # return true if self.talent_boxes.include?(box)
    return true if box.talent_row.cost == 5

    prereqs = [box.box_up, box.box_down, box.box_left, box.box_right].compact
    (self.talent_boxes - prereqs).count != self.talent_boxes.count
  end

  def all_specializations
    ids = Array(specializations.pluck(:id))
    ids << first_specialization.id
    Specialization.where(id: ids)
  end

end
