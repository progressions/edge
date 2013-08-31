# == Schema Information
#
# Table name: obligations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  amount       :integer
#  character_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Obligation < ActiveRecord::Base
  belongs_to :character

  OBLIGATIONS_TABLE = {
    1..8 => {
      name: "Addiction",
      description: ""
    },
    9..16 => {
      name: "Betrayal",
      description: ""
    },
    17..24 => {
      name: "Blackmail",
      description: ""
    },
    25..32 => {
      name: "Bounty",
      description: ""
    },
    33..40 => {
      name: "Criminal",
      description: ""
    },
    41..48 => {
      name: "Debt",
      description: ""
    },
    49..56 => {
      name: "Dutybound",
      description: ""
    },
    57..64 => {
      name: "Family",
      description: ""
    },
    65..72 => {
      name: "Favor",
      description: ""
    },
    73..80 => {
      name: "Oath",
      description: ""
    },
    81..88 => {
      name: "Obsession",
      description: ""
    },
    89..96 => {
      name: "Reponsibility",
      description: ""
    }
  }

  def self.random_value(index)
    OBLIGATIONS_TABLE.select do |range, values|
      range.include?(index)
    end.first.second
  end

  def self.random_obligation_values
    index = (rand * 100).to_i + 1
    if index > 96
      [random_obligation_values, random_obligation_values]
    else
      random_value(index)
    end
  end

  def self.randomize
    random_values = [random_obligation_values].flatten
    random_values.map do |values|
      new do |o|
        o.name = values[:name]
        o.description = values[:description]
      end
    end
  end
end
