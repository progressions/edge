class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.belongs_to :skill
      t.string :source

      t.timestamps
    end
  end
end
