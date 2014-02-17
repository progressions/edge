# == Schema Information
#
# Table name: talent_rows
#
#  id                :integer          not null, primary key
#  specialization_id :integer
#  cost              :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class TalentRow < ActiveRecord::Base
  belongs_to :specialization

  def directions=(values)
    dirs = values["Direction"]
    @talent_keys.each_with_index do |key, i|
      talent = Talent.lookup(key)
      directions = parse_directions(dirs[i])
      thing = {
        talent: talent,
        direction: directions
      }
      puts thing.inspect
    end
    raise "yay"
  end

  def talents=(values)
    @talent_keys = values["Key"]
  end

  def parse_directions(value)
    {
      up: value["Up"] == "true",
      down: value["Down"] == "true",
      left: value["Left"] == "true",
      right: value["Right"] == "true"
    }
  end
end
