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

class CharacterOption < ActiveRecord::Base
  belongs_to :character

  serialize :starting_skills, Hash
end
