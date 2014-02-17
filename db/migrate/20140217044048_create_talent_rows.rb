class CreateTalentRows < ActiveRecord::Migration
  def change
    create_table :talent_rows do |t|
      t.belongs_to :specialization, index: true
      t.integer :cost

      t.timestamps
    end
  end
end
