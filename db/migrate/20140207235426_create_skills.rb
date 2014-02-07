class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :key
      t.string :name
      t.text :description
      t.string :source
      t.string :char_key

      t.timestamps
    end
  end
end
