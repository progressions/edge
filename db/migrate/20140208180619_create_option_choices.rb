class CreateOptionChoices < ActiveRecord::Migration
  def change
    create_table :option_choices do |t|
      t.integer :species_id
      t.string :key
      t.string :name

      t.timestamps
    end
  end
end
