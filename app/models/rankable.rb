class Rankable < ActiveRecord::Base
  belongs_to :rank
  belongs_to :character, foreign_key: "parent_id"
end
