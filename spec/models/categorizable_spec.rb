# == Schema Information
#
# Table name: categorizables
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  categorizable_id   :integer
#  categorizable_type :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Categorizable do
  pending "add some examples to (or delete) #{__FILE__}"
end
