class Category < ActiveRecord::Base
  belongs_to :weapon, polymorphic: true
end
