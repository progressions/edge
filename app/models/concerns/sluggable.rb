module Sluggable
  extend ActiveSupport::Concern

  included do
    def self.lookup(slug)
      where(slug: slug).first
    end
  end
end
