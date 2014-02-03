class CreateExperienceRanks < ActiveRecord::Migration
  def change
    create_table :experience_ranks do |t|
      t.integer :character_id
      t.integer :amount
      t.string :source

      t.timestamps
    end
  end
end
