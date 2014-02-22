# == Schema Information
#
# Table name: character_talent_boxes
#
#  id            :integer          not null, primary key
#  character_id  :integer
#  talent_box_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class CharacterTalentBox < ActiveRecord::Base
  belongs_to :character
  belongs_to :talent_box

  def talent
    self.talent_box.try(:talent)
  end

  def talent_id
    self.talent.try(:id)
  end

  def character_talent
    self.character.character_talents.where(talent_id: self.talent_id).first
  end

  delegate :purchased_amount, to: :character_talent

  def valid_box?
    self.talent_box.talent_row.cost == 5 || connection_costs.include?(5)
  end

  def connection_costs
    connected_rows.map(&:cost).uniq
  end

  def connected_rows
    connected_boxes.map(&:talent_row)
  end

  def connected_boxes
    all_connections.map(&:talent_box)
  end

  def connections
    [box_left, box_right, box_up, box_down].compact.flatten
  end

  def all_connections
    @all_connections = []

    recurse = Proc.new do |ctb|
      unless @all_connections.include?(ctb)
        @all_connections << ctb
        ctb.connections.each do |new_ctb|
          recurse.call(new_ctb)
        end
      end
    end

    self.connections.each do |new_ctb|
      recurse.call(new_ctb)
    end

    @all_connections.flatten.compact
  end

  def box_up
    character.character_talent_boxes.where(talent_box_id: self.talent_box.box_up.try(:id)).first
  end

  def box_down
    character.character_talent_boxes.where(talent_box_id: self.talent_box.box_down.try(:id)).first
  end

  def box_left
    character.character_talent_boxes.where(talent_box_id: self.talent_box.box_left.try(:id)).first
  end

  def box_right
    character.character_talent_boxes.where(talent_box_id: self.talent_box.box_right.try(:id)).first
  end
end
