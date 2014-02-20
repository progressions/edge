# == Schema Information
#
# Table name: talent_boxes
#
#  id            :integer          not null, primary key
#  talent_row_id :integer
#  key           :string(255)
#  position      :integer
#  left          :boolean
#  right         :boolean
#  up            :boolean
#  down          :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class TalentBox < ActiveRecord::Base
  belongs_to :talent_row

  delegate :name, to: :talent
  delegate :description, to: :talent
  delegate :cost, to: :talent_row

  def talent
    Talent.lookup(key)
  end

  def self.unique_key?
    false
  end

  def left
    self.talent_row.talent_boxes.where("position < ?", self.position).first
  end

  def right
    self.talent_row.talent_boxes.where("position > ?", self.position).first
  end

  def up
    self.talent_row.row_up.talent_boxes.where(position: self.position).first
  end

  def down
    self.talent_row.row_down.talent_boxes.where(position: self.position).first
  end
end
