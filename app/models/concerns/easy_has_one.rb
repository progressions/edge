module EasyHasOne
  extend ActiveSupport::Concern

  included do
    def self.easy_has_one(key)
      klass = key.to_s.camelize.constantize

      define_method("#{key}_id") do
        self.send(key).try(:id)
      end

      # def career_id=(value)
      #   new_career = Career.find(value)
      #   unless new_career == self.career
      #     self.career_skills_by_career.delete_all
      #     self.career = new_career
      #     self.career_skills_by_career = self.career.career_skills
      #   end
      # end
      #
      define_method("#{key}_id=") do |value|
        new_record = klass.find(value)
        unless new_record == self.send(key)
          self.send("career_skills_by_#{key}").delete_all
          self.send("#{key}=", new_record)
          self.send("career_skills_by_#{key}=", self.send(key).career_skills)
        end
      end
    end
  end
end
