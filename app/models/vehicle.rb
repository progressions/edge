# == Schema Information
#
# Table name: vehicles
#
#  id                   :integer          not null, primary key
#  key                  :string(255)
#  name                 :string(255)
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  navicomputer         :boolean
#  sensor_range         :string(255)
#  crew                 :string(255)
#  encumbrance_capacity :integer
#  passengers           :integer
#  consummables         :string(255)
#  silhouette           :integer
#  speed                :integer
#  handling             :integer
#  def_fore             :integer
#  def_aft              :integer
#  def_port             :integer
#  def_starboard        :integer
#  armor                :integer
#  hull_trauma          :integer
#  system_strain        :integer
#  hp                   :integer
#  price                :integer
#  rarity               :integer
#  source               :string(255)
#  vehicle_type         :string(255)
#

class Vehicle < ActiveRecord::Base
  include CategoriesFromXml
  include Sourced

  has_many :categorizables, foreign_key: "parent_id", dependent: :destroy
  has_many :categories, through: :categorizables
end
