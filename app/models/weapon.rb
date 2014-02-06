class Weapon < ActiveRecord::Base
  def self.loader_column_names
    {
      "type" => "weapon_type"
    }
  end
end
