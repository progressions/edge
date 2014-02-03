# == Schema Information
#
# Table name: social_classes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  slug        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class SocialClass < ActiveRecord::Base
  include Sluggable

  has_many :characters
end
