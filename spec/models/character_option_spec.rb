# == Schema Information
#
# Table name: character_options
#
#  id              :integer          not null, primary key
#  character_id    :integer
#  choice_key      :string(255)
#  option_key      :string(255)
#  starting_skills :text
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe CharacterOption do
  pending "add some examples to (or delete) #{__FILE__}"
end
