module HasRanks
  extend ActiveSupport::Concern

  included do
    klass_name = self.name.to_s.camelize

    has_many :ranks, -> { where(parent_type: klass_name) }

    [:purchased, :career, :specialization, :species, :attach, :talent, :item].each do |key|
      rank_klass = "#{key}_rank".camelize.constantize

      # has_many :career_ranks
      #
      has_many "#{key}_ranks".to_sym, -> { where(parent_type: klass_name) }, foreign_key: "parent_id", class_name: rank_klass.name

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

      # set_career_ranks(amount)
      #
      define_method("set_#{key}_ranks") do |amount|
        # execute callback
        #
        old_amount = self.send("#{key}_amount")
        new_amount = amount

        if self.respond_to?("after_#{key}_rank")
          self.send("after_#{key}_rank", old_amount.to_i, new_amount.to_i)
        end

        # end callback

        self.send("set_#{key}_rank", amount)
      end

      # set_career_rank(amount)
      #
      define_method("set_#{key}_rank") do |amount|
        if self.send("#{key}_ranks").count == 0
          self.send("#{key}_ranks=", [rank_klass.create(amount: amount, parent_type: klass_name)])
        else
          self.send("#{key}_ranks").first.update_attributes(amount: amount)
        end
      end
    end
  end
end
