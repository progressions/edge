class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :amount
      t.string :source
      t.string :type

      t.timestamps
    end
  end
end
