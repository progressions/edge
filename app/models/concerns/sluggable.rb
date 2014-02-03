module Sluggable
  extend ActiveSupport::Concern

  included do
    def self.lookup(key)
      where(key: key).first
    end
  end
end
