module HasRanks
  extend ActiveSupport::Concern

  included do
    klass_name = self.name.to_s.camelize

    has_many :rankables, foreign_key: "parent_id", dependent: :destroy
    has_many :ranks, -> { where(parent_type: klass_name) }, through: :rankables, dependent: :destroy

    [:purchased, :career, :specialization, :species, :attach, :talent, :obligation, :duty, :item].each do |key|
      rank_klass = "#{key}_rank".camelize.constantize

      # has_many :career_ranks
      #
      has_many "#{key}_ranks".to_sym, -> { where(parent_type: klass_name) }, through: :rankables, source: :rank, class_name: rank_klass.name, dependent: :destroy

      define_method("total_amount") do
        ranks.sum(:amount)
      end

      define_method("non_purchased_amount") do
        total_amount.to_i - purchased_amount.to_i
      end

      # career_amount
      #
      define_method("#{key}_amount") do
        send("first_#{key}_rank").try(:amount).to_i
      end

      # first_career_rank
      #
      define_method("first_#{key}_rank") do
        self.send("#{key}_ranks").first
      end

      # set_career_ranks=(amount)
      #
      define_method("set_#{key}_ranks") do |amount|
        rankables = self.send("#{key}_rankables")

        if amount.to_i == 0
          ranks = self.send("#{key}_ranks")

          rankables.map(&:destroy)
          ranks.map(&:destroy)
        else
          rankables.map(&:destroy)

          if self.send("#{key}_ranks").count == 0
            self.send("#{key}_ranks=", [rank_klass.create(amount: amount, parent_type: klass_name)])
          else
             self.send("#{key}_ranks").first.update_attributes(amount: amount)
          end
        end
      end

      # def career_rankables
      #   career_ranks.map(&:rankables)
      # end
      #
      define_method("#{key}_rankables") do
        send("#{key}_ranks").map(&:rankables)
      end
    end
  end
end
