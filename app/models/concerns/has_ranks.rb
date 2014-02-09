module HasRanks
  extend ActiveSupport::Concern

  included do
    klass_name = self.name.to_s.camelize

    has_many :rankables, foreign_key: "parent_id", dependent: :destroy
    has_many :ranks, -> { where(parent_type: klass_name) }, through: :rankables, dependent: :destroy

    [:purchased, :career, :specialization, :species, :attach, :talent].each do |key|
      rank_klass = "#{key}_rank".camelize.constantize

      has_many "#{key}_ranks".to_sym, -> { where(parent_type: klass_name) }, through: :rankables, source: :rank, class_name: rank_klass.name

      define_method("#{key}_amount") do
        send("first_#{key}_rank").try(:amount).to_i
      end

      define_method("first_#{key}_rank") do
        self.send("#{key}_ranks").first
      end

      define_method("set_#{key}_ranks") do |amount|
        if self.send("#{key}_ranks").any?
          self.send("#{key}_ranks").first.update_attributes(amount: amount)
        else
          self.send("#{key}_ranks").delete_all
          self.send("#{key}_ranks=", [rank_klass.create(amount: amount, parent_type: klass_name)])
        end
      end
    end
  end
end
