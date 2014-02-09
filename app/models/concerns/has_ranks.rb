module HasRanks
  extend ActiveSupport::Concern

  included do
    klass_name = self.name.to_s.camelize

    has_many :rankables, foreign_key: "parent_id", dependent: :destroy
    has_many :ranks, -> { where(parent_type: klass_name) }, through: :rankables, dependent: :destroy
    has_many :purchased_ranks, -> { where(parent_type: klass_name) }, through: :rankables, source: :rank, class_name: "PurchasedRank"
    has_many :career_ranks, -> { where(parent_type: klass_name) }, through: :rankables, source: :rank, class_name: "CareerRank"
  end
end
