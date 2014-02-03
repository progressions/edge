class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :value
      t.string :source

      t.timestamps
    end
  end
end
