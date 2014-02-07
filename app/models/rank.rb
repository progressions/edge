class Rank < ActiveRecord::Base
  has_many :rankables
  has_many :characters, through: :rankables

  def self.by_obligation
    where(source: "obligation")
  end
end
