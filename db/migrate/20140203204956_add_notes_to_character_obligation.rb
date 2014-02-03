class AddNotesToCharacterObligation < ActiveRecord::Migration
  def change
    add_column :character_obligations, :notes, :text
  end
end
