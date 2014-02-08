class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :option_choice_id
      t.string :key
      t.string :name
      t.string :description
      t.boolean :starting_skill_training
      t.integer :skill_count
      t.boolean :non_career

      t.timestamps
    end
  end
end
