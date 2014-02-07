# == Schema Information
#
# Table name: careers
#
#  id          :integer          not null, primary key
#  key         :string(255)
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  source      :string(255)
#

class Career < ActiveRecord::Base
end
